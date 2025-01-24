import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../data/response/status.dart';
import '../../../../viewModel/course_viewmodel.dart';
import '../../../../model/course.dart';
import '../../../screen/enrollments/enrollment_provider.dart';
import 'enroll_successful_screen.dart';

class EnrollStep3 extends StatefulWidget {
  const EnrollStep3({super.key, required EnrollmentFormData formData});
  @override
  State<EnrollStep3> createState() => _EnrollStep3State();
}

class ClassOption {
  final String title;
  final String timeRange;

  const ClassOption({
    required this.title,
    required this.timeRange,
  });
}

class _EnrollStep3State extends State<EnrollStep3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Selected state variables
  Course? _selectedCourseData;
  String? _selectedClass;
  String? _selectedShift;
  String? _selectedHour;

  // Class options remain constant
  static const List<ClassOption> classOptions = [
    ClassOption(title: 'Evening-Weekday', timeRange: '06:00 PM - 08:00 PM'),
    ClassOption(title: 'Morning-Weekday', timeRange: '08:00 AM - 10:00 AM'),
    ClassOption(title: 'Afternoon-Weekend', timeRange: '12:00 PM - 05:00 PM'),
    ClassOption(title: 'Morning-Weekend', timeRange: '08:00 AM - 12:00 PM'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CourseViewmodel>(context, listen: false).fetchAllBlogs();
    });
  }

  Widget _buildCourseDropdown(CourseViewmodel viewModel) {
    List<Course> courses = viewModel.getCourseData;

    return SizedBox(
      width: double.infinity,
      child: DropdownMenu<Course>(
        width: 398,
        menuHeight: 450,
        hintText: 'Select Course',
        errorText: _formKey.currentState?.validate() == false && _selectedCourseData == null
            ? 'Please select a course'
            : null,
        leadingIcon: _selectedCourseData != null
            ? Padding(
          padding: const EdgeInsets.only(left: 12.0,),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _selectedCourseData!.thumbnailUri,
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
          color: _selectedCourseData != null ? Colors.black : Colors.black,
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
        dropdownMenuEntries: courses.map((course) => DropdownMenuEntry(
          value: course,
          label: course.title,
          // Modify the leadingIcon to match the example
          leadingIcon: Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                course.thumbnailUri,
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
          style: ButtonStyle(
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            foregroundColor: WidgetStateProperty.all(Colors.black),
            textStyle: WidgetStateProperty.resolveWith(
                  (_) => const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        )).toList(),
        onSelected: (Course? course) {
          setState(() {
            _selectedCourseData = course;
            _selectedClass = null;
            _selectedShift = null;
            _selectedHour = null;
          });
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
    if (_selectedCourseData == null || _selectedClass == null) {
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
          _buildSelectionRow(_selectedCourseData!.title, () {
            setState(() {
              _selectedCourseData = null;
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
            'Course Fee: \$${_selectedCourseData!.fee}',
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 12),
          Text(
            'Total Hours: ${_selectedCourseData!.totalHour}',
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 12),
          Text(
            'Level: ${_selectedCourseData!.level}',
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 12),
          Text(
            'Total Lessons: ${_selectedCourseData!.totalLesson}',
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
    bool isSelected = _selectedClass == classOption.title;

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
            _selectedClass = classOption.title;
            _selectedShift = classOption.title.split('-')[0].trim();
            _selectedHour = classOption.timeRange;
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
                classOption.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                classOption.timeRange,
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
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Enrollment Screen',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Consumer<CourseViewmodel>(
        builder: (context, viewModel, _) {
          switch (viewModel.course.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());

            case Status.ERROR:
              return Center(
                child: Text('Error: ${viewModel.course.message}'),
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
                          if (_selectedCourseData != null) ...[
                            const SizedBox(height: 16),
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
                            if (_selectedClass != null) _buildSelectionSummary(),
                          ],
                          const SizedBox(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
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
                                onPressed: _selectedClass != null
                                    ? () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EnrollSuccessfulScreen(
                                              course:
                                              _selectedCourseData!.title,
                                              classTime:
                                              _selectedHour ?? 'Unknown Time',
                                            ),
                                      ),
                                    );
                                  }
                                }
                                    : null,
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
          }
        },
      ),
    );
  }
}