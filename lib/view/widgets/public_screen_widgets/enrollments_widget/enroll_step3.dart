import 'package:flutter/material.dart';
import 'package:lms_mobile/viewModel/enroll/available_course_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../data/network/enrollment_service.dart';
import '../../../../data/response/status.dart';
import '../../../../model/admission/admission_form.dart';
import '../../../../model/enrollmentRequest/register_model.dart';
import '../../../../model/enrollment_response/available_course_model.dart';
import '../../../../repository/enroll/enroll_repository.dart';
import '../../../../repository/enroll/enroll_step3_repo.dart';
import '../../../../resource/app_url.dart';
import '../../../../viewModel/enroll/enroll_view_model.dart';
import '../../../../viewModel/enroll/enrollment_view_model.dart';
import 'enroll_step2.dart';
import 'enroll_successful_screen.dart';

class EnrollStep3 extends StatefulWidget {
  final String uuid;
  const EnrollStep3({super.key, required this.uuid});

  @override
  State<EnrollStep3> createState() => _EnrollStep3State();
}

class ClassOption {
  final String shift;
  final String startTimeAsStr;
  final String endTimeAsStr;

  ClassOption({
    required this.shift,
    required this.startTimeAsStr})
      : endTimeAsStr = _calculateEndTime(startTimeAsStr);

  static String _calculateEndTime(String startTimeAsStr) {
    final times = startTimeAsStr.split(' - ');
    if (times.length == 2) {
      return times[1];
    }
    return 'Invalid Time Format';
  }
}

class _EnrollStep3State extends State<EnrollStep3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  List<ClassOption> classOptions = [
    ClassOption(shift: 'Evening-Weekday', startTimeAsStr: '06:00 PM - 08:00 PM'),
    ClassOption(shift: 'Morning-Weekday', startTimeAsStr: '08:00 AM - 10:00 AM'),
    ClassOption(shift: 'Afternoon-Weekend', startTimeAsStr: '12:00 PM - 05:00 PM'),
    ClassOption(shift: 'Morning-Weekend', startTimeAsStr: '08:00 AM - 12:00 PM'),
  ];

  Future<void> submitEnrollmentData() async {
    final prefs = await SharedPreferences.getInstance();

    // Collect data from all steps
    final fullName = prefs.getString('fullName');
    final email = prefs.getString('email');
    final gender = prefs.getString('gender');
    final phone = prefs.getInt('phoneNumber');
    final birthDate = prefs.getString('birthDate');
    final birthAddress = prefs.getString('birthAddress');
    final currentAddress = prefs.getString('currentAddress');
    final education = prefs.getString('education');
    final university = prefs.getString('university');

    if (fullName == null || email == null || gender == null || phone == null || birthDate == null || birthAddress == null || currentAddress == null || education == null || university == null) {

      return;
    }

    final enrollmentData = {
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'phone': phone,
      'birthDate': birthDate,
      'birthAddress': birthAddress,
      'currentAddress': currentAddress,
      'education': education,
      'university': university,
    };

    print('Submitting Enrollment Data: $enrollmentData');
  }

  String? fullName;
  String? email;
  String? gender;
  String? phone;
  DateTime? _selectedBirthDate;
  String? _selectedBirthAddress;
  String? _selectedCurrentAddress;
  String? _selectedEducation;
  String? _selectedUniversity;
  AvailableCourseDataList? _selectedAvailableCourseData;
  String? _selectedClass;
  String? _selectedShift;
  String? _selectedHour;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('Fetching available courses...');
      Provider.of<AvailableCourseViewModel>(context, listen: false).fetchAvailableCourseAllBlogs();
      if (widget.uuid != null && widget.uuid.isNotEmpty) {
        print('Fetching course details for UUID: ${widget.uuid}');
        Provider.of<AvailableCourseViewModel>(context, listen: false)
            .fetchCourseDetail(widget.uuid);
      } else {
        print('Error: UUID is null or empty. UUID value: ${widget.uuid}');
      }
    });
  }
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName') ?? '';
      email = prefs.getString('email') ?? '';
      gender = prefs.getString('gender') ?? '';
      phone = prefs.getString('phoneNumber') ?? '';
      _selectedBirthDate = DateTime.tryParse(prefs.getString('birthDate') ?? '');
      _selectedBirthAddress = prefs.getString('birthAddress') ?? '';
      _selectedCurrentAddress = prefs.getString('currentAddress') ?? '';
      _selectedEducation = prefs.getString('education') ?? '';
      _selectedUniversity = prefs.getString('university') ?? '';
      _selectedAvailableCourseData = null;
      _selectedClass = null;
      _selectedShift = null;
      _selectedHour = null;
    });
  }

  Future<void> handleEnrollment() async {
    if (!_formKey.currentState!.validate() || _selectedClass == null) {
      _showErrorSnackBar('Please complete all required fields');
      return;
    }

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      final enrollmentVM = context.read<EnrollmentViewModel>();
      final enrollVM = context.read<EnrollViewModel>();

      // Create enrollment data model
      final enrollmentData = EnrollmentModel(
        id: 0,
        uuid: '',
        dob: _selectedBirthDate!,
        pob: _createAddressModel(_selectedBirthAddress!, 'BIRTH'),
        currentAddress: _createAddressModel(_selectedCurrentAddress!, 'CURRENT'),
        photoUri: '',
        universityInfo: _createAddressModel(_selectedUniversity!, 'EDUCATION'),
        email: email ?? '',
        nameEn: fullName ?? '',
        nameKh: null,
        gender: gender ?? '',
        phoneNumber: phone ?? '',
      );

      // First enroll the user
      await enrollmentVM.enrollUser(AppUrl.postBlogRegisterUrl, enrollmentData);

      if (enrollmentVM.status == Status.COMPLETED) {
        // Get the selected class ID
        final classId = _resolveClassId();
        if (classId == null) {
          throw Exception('Invalid class ID');
        }

        // Then enroll in the class
        await enrollVM.enrollStudent(
          classId: classId,
          studentId: enrollmentVM.enrollmentModel!.id,
        );

        if (enrollVM.status == Status.COMPLETED) {
          // Remove loading indicator
          Navigator.pop(context);

          // Navigate to success screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EnrollSuccessfulScreen(
                course: _selectedAvailableCourseData!.title,
                classTime: _selectedHour ?? 'Unknown Time',
              ),
            ),
          );
        } else {
          throw Exception('Class enrollment failed: ${enrollVM.error}');
        }
      } else {
        throw Exception('User enrollment failed: ${enrollmentVM.error}');
      }
    } catch (e) {
      // Remove loading indicator if still showing
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      _showErrorSnackBar('Enrollment failed: $e');
    }
  }

  Future<int?> _handleInitialEnrollment() async {
    final enrollmentViewModel = Provider.of<EnrollmentViewModel>(context, listen: false);

    final enrollmentData = EnrollmentModel(
      id: 0,
      uuid: '',
      dob: _selectedBirthDate!,
      pob: _createAddressModel(_selectedBirthAddress!, 'BIRTH'),
      currentAddress: _createAddressModel(_selectedCurrentAddress!, 'CURRENT'),
      photoUri: '',
      universityInfo: _createAddressModel(_selectedUniversity!, 'EDUCATION'), email: '', nameEn: '', nameKh:null, gender: '', phoneNumber: '',
    );

    await enrollmentViewModel.enrollUser(AppUrl.postBlogRegisterUrl, enrollmentData);

    if (enrollmentViewModel.status == Status.COMPLETED &&
        enrollmentViewModel.enrollmentModel != null) {
      return enrollmentViewModel.enrollmentModel!.id;
    }

    throw Exception('Initial enrollment failed: ${enrollmentViewModel.error}');
  }

  Future<void> _handleClassEnrollment(int studentId) async {
    final enrollStep3ViewModel = Provider.of<EnrollViewModel>(context, listen: false);
    final classId = _resolveClassId();

    if (classId == null) {
      throw Exception('Invalid class ID');
    }

    await enrollStep3ViewModel.enrollStudent(
      classId: classId,
      studentId: studentId,
    );

    if (enrollStep3ViewModel.status == Status.COMPLETED) {
      _navigateToSuccessScreen();
    } else {
      throw Exception('Class enrollment failed: ${enrollStep3ViewModel.error}');
    }
  }

  CurrentAddress _createAddressModel(String address, String locationType) {
    return CurrentAddress(
      id: 1,
      shortName: address,
      fullName: address,
      locationType: locationType,
    );
  }

  int? _resolveClassId() {
    return int.tryParse(_selectedClass!) ??
        _selectedAvailableCourseData?.classes
            .firstWhere((c) => c.shift == _selectedShift)
            .id;
  }

  void _navigateToSuccessScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EnrollSuccessfulScreen(
          course: _selectedAvailableCourseData!.title,
          classTime: _selectedHour ?? 'Unknown Time',
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _buildCourseDetails(AvailableCourseViewModel viewModel) {
    if (viewModel.availableCourseDetail.status == Status.LOADING) {
      return const Center(child: CircularProgressIndicator());
    } else if (viewModel.availableCourseDetail.status == Status.ERROR) {
      return Text('Error loading details: ${viewModel.availableCourseDetail.message}');
    } else if (viewModel.availableCourseDetail.status == Status.COMPLETED &&
        viewModel.getCourseDetail != null) {
      final courseDetail = viewModel.getCourseDetail!.data;

      // Update available class options based on API response
      List<ClassOption> apiClassOptions = courseDetail.classes.map((classData) {
        return ClassOption(
            shift: classData.shift,
            startTimeAsStr: '${classData.startTimeAsStr} - ${classData.endTimeAsStr}'
        );
      }).toList();

      // Use API class options if available, otherwise fall back to default options
      classOptions = apiClassOptions.isNotEmpty ? apiClassOptions : classOptions;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '* Please select the class:',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: classOptions
                .map((option) => _buildClassCard(option))
                .toList(),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }


  Widget _buildCourseDropdown(AvailableCourseViewModel viewModel) {
    List<AvailableCourseDataList> availableCourses = viewModel.getAvailableCourseData;
    print("Dropdown data: ${availableCourses.map((e) => e.title).toList()}");
    return SizedBox(
      width: double.infinity,
      child: DropdownMenu<AvailableCourseDataList>(
        width: 398,
        menuHeight: 450,
        hintText: 'Select Course',
        errorText: _formKey.currentState?.validate() == false && _selectedAvailableCourseData == null
            ? 'Please select a course'
            : null,
        leadingIcon: _selectedAvailableCourseData != null
            ? Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _selectedAvailableCourseData!.thumbnailUri,
              width: 10,
              height: 10,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 10,
                  height: 10,
                  child: Icon(Icons.image_not_supported, size: 2, color: Colors.black),
                );
              },
            ),
          ),
        )
            : null,
        textStyle: TextStyle(
          fontSize: 16,
          color: _selectedAvailableCourseData != null ? Colors.black : Colors.black,
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: _buildBorder(),
          enabledBorder: _buildBorder(color: Colors.grey),
          focusedBorder: _buildBorder(color: AppColors.primaryColor),
          errorBorder: _buildBorder(color: Colors.red),
          focusedErrorBorder: _buildBorder(color: Colors.red),
          filled: true,
          fillColor: Colors.white,
        ),
        dropdownMenuEntries: availableCourses.map((availableCourse) {
          return DropdownMenuEntry(
            value: availableCourse,
            label: availableCourse.title,
            leadingIcon: Container(
              margin: const EdgeInsets.only(right: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  availableCourse.thumbnailUri,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      width: 32,
                      height: 32,
                      child: Icon(Icons.image_not_supported, size: 16, color: Colors.black),
                    );
                  },
                ),
              ),
            ),
          );
        }).toList(),
        onSelected: (AvailableCourseDataList? availableCourse) {
          setState(() {
            _selectedAvailableCourseData = availableCourse;
            _selectedClass = null;
            _selectedShift = null;
            _selectedHour = null;
            print('Selected course updated: ${availableCourse?.uuid}');
          });
          if (availableCourse != null) {
            print('Fetching course details for UUID: ${availableCourse.uuid}');
            Provider.of<AvailableCourseViewModel>(context, listen: false)
                .fetchCourseDetail(availableCourse.uuid);
          }
        },
        enableSearch: true,
        requestFocusOnTap: true,
        enableFilter: true,
      ),
    );
  }

  OutlineInputBorder _buildBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildSelectionSummary() {
    if (_selectedAvailableCourseData == null || _selectedClass == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '* Your selected class:',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSelectionRow(_selectedAvailableCourseData!.title, () {
            setState(() {
              _selectedAvailableCourseData = null;
              _selectedClass = null;
              _selectedShift = null;
              _selectedHour = null;
            });
          }),
          if (_selectedShift != null)
            _buildSelectionRow('Shift = $_selectedShift', () {
              setState(() {
                _selectedShift = null;
                _selectedClass = null;
                _selectedHour = null;
              });
            }),
          if (_selectedHour != null)
            _buildSelectionRow('Hour = $_selectedHour', () {
              setState(() {
                _selectedHour = null;
                _selectedClass = null;
              });
            }),
          const SizedBox(height: 15),
          // Display additional course information
          Text(
            'Course Fee: \$${_selectedAvailableCourseData!.fee}',
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 12),
          Text(
            'Total Hours: ${_selectedAvailableCourseData!.totalHour}',
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 12),
          Text(
            'Level: ${_selectedAvailableCourseData!.level}',
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 12),
          Text(
            'Total Lessons: ${_selectedAvailableCourseData!.totalLesson}',
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionRow(String text, VoidCallback onRemove) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: onRemove,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(ClassOption classOption) {
    bool isSelected = _selectedClass == classOption.shift;

    return Card(
      elevation: isSelected ? 2 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          width: 1,
        ),
      ),
      color: isSelected ? AppColors.primaryColor : Colors.grey[100],
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedClass = classOption.shift;
            _selectedShift = classOption.shift.split('-')[0].trim();
            _selectedHour = classOption.startTimeAsStr;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isSelected)
                const Icon(Icons.check, color: AppColors.successColor, size: 35),
              const SizedBox(height: 12),
              Text(
                classOption.shift,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                classOption.startTimeAsStr,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EnrollStep2(
                ),
              ),
            );
          },
        ),
        title: const Text(
          'Enrollment Screen',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Consumer<AvailableCourseViewModel>(
        builder: (context, viewModel, _) {
          switch (viewModel.availableCourse.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());

            case Status.ERROR:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${viewModel.availableCourse.message}'),
                    ElevatedButton(
                      onPressed: () => viewModel.fetchAvailableCourseAllBlogs(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );

            case Status.COMPLETED:
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Course',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildCourseDropdown(viewModel),
                          if (_selectedAvailableCourseData != null) ...[
                            const SizedBox(height: 16),
                            const SizedBox(height: 8),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            _buildCourseDetails(viewModel),
                            if (_selectedClass != null) _buildSelectionSummary(),
                          ],
                          const SizedBox(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => EnrollStep2()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 25,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Previous',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.defaultGrayColor,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: _selectedClass != null ? handleEnrollment : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 24,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  disabledBackgroundColor: Colors.grey,
                                ),
                                child: const Text(
                                  'Enroll Now',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.defaultWhiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            case null:
              throw UnimplementedError();
            case Status.IDLE:
              throw UnimplementedError();
          }
        },
      ),
    );
  }
}
