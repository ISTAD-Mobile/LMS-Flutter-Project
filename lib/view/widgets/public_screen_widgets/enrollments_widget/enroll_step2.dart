import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lms_mobile/model/enrollmentRequest/register_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/viewModel/enroll/current_address_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/university_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/place_of_birth_view_model.dart';
import '../../../../viewModel/enroll/enroll_view_model.dart';
import 'enroll_step1.dart';
import 'enroll_step3.dart';

class EnrollStep2 extends StatefulWidget {
  const EnrollStep2({super.key});

  @override
  State<EnrollStep2> createState() => _CourseEnrollForm();
}

class _CourseEnrollForm extends State<EnrollStep2> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormSubmitted = false;

  DateTime? _selectedBirthDate;
  String? _selectedBirthAddress;
  String? _selectedCurrentAddress;
  String? _selectedEducation;
  String? _selectedUniversity;

  final enrollmentViewmodel = EnrollViewModel();

  static const int _minAge = 16;
  static const int _maxAge = 100;
  static const List<String> educationOptions = [
    'Association',
    'Bachelor',
    'Master',
    'PhD',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    Future.microtask(() {
      context.read<PlaceOfBirthViewModel>().fetchPlaceOfBlogs();
      context.read<CurrentAddressViewModel>().fetchCurrentAddressBlogs();
      context.read<UniversityViewModel>().fetchUniversityBlogs();
    });
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      String? birthDateString = prefs.getString('dob');
      _selectedBirthDate = birthDateString != null ? DateTime.tryParse(birthDateString) : null;
      _selectedBirthAddress = prefs.getString('birthAddress');
      _selectedCurrentAddress = prefs.getString('currentAddress');
      _selectedEducation = prefs.getString('education');
      _selectedUniversity = prefs.getString('university');
    });
  }

  bool _validateForm() {
    return _selectedBirthDate != null &&
        _selectedBirthAddress != null &&
        _selectedCurrentAddress != null &&
        _selectedEducation != null &&
        _selectedUniversity != null;
  }

  Future<int?> _saveStep2DataEnrollment() async {
    final prefs = await SharedPreferences.getInstance();

    // Save selected values to SharedPreferences
    await prefs.setString('dob', _selectedBirthDate?.toIso8601String() ?? '');
    await prefs.setString('birthAddress', _selectedBirthAddress ?? '');
    await prefs.setString('currentAddress', _selectedCurrentAddress ?? '');
    await prefs.setString('education', _selectedEducation ?? '');
    await prefs.setString('university', _selectedUniversity ?? '');

    var enrollmentModel = EnrollmentModel(
      email: prefs.getString('email') ?? '',
      nameEn: prefs.getString('nameEn') ?? '',
      gender: prefs.getString('gender') ?? '',
      dob: _selectedBirthDate,
      pob: CurrentAddress(id: 1, shortName: _selectedBirthAddress ?? 'Default', nameEn: _selectedBirthAddress ?? 'Default Address'),
      currentAddress: CurrentAddress(id: 1, shortName: _selectedCurrentAddress ?? 'Default', nameEn: _selectedCurrentAddress ?? 'Default Address'),
      phoneNumber: prefs.getString('phoneNumber') ?? '',
      photoUri: prefs.getString('photoUri') ?? '',
      universityInfo: CurrentAddress(id: 1, shortName: _selectedUniversity ?? 'Default', nameEn: _selectedUniversity ?? 'Default University Info'),
    );

    try {
      final response = await enrollmentViewmodel.postEnrollment(enrollmentModel);

      if (response != null && response['code'] == 200) {
        var responseData = response['data'];
        var id = responseData['id'];
        prefs.setInt('studentId', id);
        return id;
      } else {
        throw Exception('Failed to submit enrollment');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  void _showDatePicker() {
    final now = DateTime.now();
    final minDate = DateTime(now.year - _maxAge);
    final maxDate = DateTime(now.year - _minAge);

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: _selectedBirthDate ?? maxDate,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            maximumDate: maxDate,
            minimumDate: minDate,
            onDateTimeChanged: (DateTime newDate) {
              setState(() => _selectedBirthDate = newDate);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownMenu({
    required String hint,
    required List<String> options,
    required String? selectedValue,
    required void Function(String?) onSelected,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      width: double.infinity,
      child: DropdownMenu<String>(
        width: 398,
        menuHeight: 250,
        hintText: hint,
        errorText: _isFormSubmitted && selectedValue == null ? 'Please $hint' : null,
        textStyle: const TextStyle(fontSize: 16, color: Colors.black),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        dropdownMenuEntries: options.map((e) =>
            DropdownMenuEntry(value: e, label: e)
        ).toList(),
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EnrollStep1(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFormField(
                  'Date of Birth',
                  GestureDetector(
                    onTap: _showDatePicker,
                    child: _buildDateField(),
                  ),
                ),
                _buildFormField(
                  'Place of birth',
                  Consumer<PlaceOfBirthViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: _selectedBirthAddress?.isNotEmpty == true
                          ? _selectedBirthAddress!
                          : 'Select place of birth',
                      options: viewModel.placeOfBirthList,
                      selectedValue: _selectedBirthAddress,
                      // onSelected: (value) => setState(() => _selectedBirthAddress = value),
                      onSelected: (value) async {
                        setState(() {
                          _selectedBirthAddress = value;
                        });

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('Birth Address', value ?? '');
                      },
                    ),
                  ),
                ),
                _buildFormField(
                  'Current address',
                  Consumer<CurrentAddressViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: _selectedCurrentAddress?.isNotEmpty == true
                          ? _selectedCurrentAddress!
                          : 'Select current address',
                      options: viewModel.currentAddressList,
                      selectedValue: _selectedCurrentAddress,
                      onSelected: (value) async {
                        setState(() {
                          _selectedCurrentAddress = value;
                        });

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('Current Address', value ?? '');
                      },
                      // onSelected: (value) => setState(() => _selectedCurrentAddress = value),
                    ),
                  ),
                ),
                _buildFormField(
                  'Education',
                  _buildDropdownMenu(
                    hint: _selectedEducation?.isNotEmpty == true
                        ? _selectedEducation!
                        : 'Select education',
                    options: educationOptions,
                    selectedValue: _selectedEducation,
                    onSelected: (value) async {
                      setState(() {
                        _selectedEducation = value;
                      });

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('Education', value ?? '');
                    },
                    // onSelected: (value) => setState(() => _selectedEducation = value),
                  ),
                ),
                _buildFormField(
                  'University',
                  Consumer<UniversityViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: _selectedUniversity?.isNotEmpty == true
                          ? _selectedUniversity!
                          : 'Select University',
                      options: viewModel.universityList,
                      selectedValue: _selectedUniversity,
                      onSelected: (value) async {
                        setState(() {
                          _selectedUniversity = value;
                        });

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('University', value ?? '');
                      },
                      // onSelected: (value) => setState(() => _selectedUniversity = value),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedBirthDate != null
                ? '${_selectedBirthDate!.year}-${_selectedBirthDate!.month.toString().padLeft(2, '0')}-${_selectedBirthDate!.day.toString().padLeft(2, '0')}'
                : 'Select Date of Birth',
            style: const TextStyle(fontSize: 16),
          ),
          const Icon(CupertinoIcons.calendar, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        child,
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Previous',
            style: TextStyle(color: AppColors.defaultGrayColor, fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            setState(() => _isFormSubmitted = true);

            if (_validateForm()) {
              try {
                int? id = await _saveStep2DataEnrollment();

                if (id != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnrollStep3(studentId: id.toString(), classId: ''),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enrollment failed. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill out all fields.', style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Select Course',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        )
      ],
    );
  }
}