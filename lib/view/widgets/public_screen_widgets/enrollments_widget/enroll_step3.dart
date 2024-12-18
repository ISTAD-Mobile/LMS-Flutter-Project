import 'package:flutter/material.dart';
import '../../../../data/color/color_screen.dart';
import 'enroll_successful_screen.dart';

class EnrollStep3 extends StatefulWidget {
  const EnrollStep3({super.key});
  @override
  _EnrollStep3State createState() => _EnrollStep3State();
}

class _EnrollStep3State extends State<EnrollStep3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _courses = [
    'Web design',
    'Java',
    'Block Chain',
    'DevOps',
    'Python',
    'Artificial Intelligence'
  ];
  String? _selectedClass;
  String? _selectedCourse;
  String? _selectedShift;
  String? _selectedHour;

  Widget _buildDropdownMenu({
    required String hint,
    required List<String> options,
    required String? selectedValue,
    required void Function(String?) onSelected,
  }) {
    return SizedBox(
      width: double.infinity,
      child: DropdownMenu<String>(
        width: 398,
        hintText: hint,
        errorText: _formKey.currentState?.validate() == false && selectedValue == null ? 'Please select $hint' : null,
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey,),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey,),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        dropdownMenuEntries: options.map((e) =>
            DropdownMenuEntry(
              value: e,
              label: e,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                foregroundColor: WidgetStateProperty.all(Colors.black),
                textStyle: WidgetStateProperty.resolveWith((states) {
                  return const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                  );
                }),
              ),
            ),
        ).toList(),
        onSelected: onSelected,
        enableSearch: true,
        requestFocusOnTap: true,
        enableFilter: true,
      ),
    );
  }

  Widget _buildSelectionSummary() {
    if (_selectedCourse == null || _selectedClass == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
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
          _buildSelectionRow(_selectedCourse!, () {
            setState(() {
              _selectedCourse = null;
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
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  _buildDropdownMenu(
                    hint: 'Select Course',
                    options: _courses,
                    selectedValue: _selectedCourse,
                    onSelected: (value) {
                      setState(() {
                        _selectedCourse = value;
                        _selectedClass = null;
                        _selectedShift = null;
                        _selectedHour = null;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  if (_selectedCourse != null) ...[
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
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        _buildClassCard('Evening-Weekday', '06:00 PM - 08:00 PM'),
                        _buildClassCard('Morning-Weekday', '08:00 AM - 10:00 AM'),
                        _buildClassCard('Afternoon-Weekend', '12:00 PM - 05:00 PM'),
                        _buildClassCard('Morning-Weekend', '08:00 AM - 12:00 PM'),
                      ],
                    ),
                    if (_selectedClass != null) _buildSelectionSummary(),
                  ],
                  const SizedBox(height: 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Previous',
                          style: TextStyle(fontSize: 16, color: AppColors.defaultGrayColor),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _selectedClass != null
                            ? () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EnrollSuccessfulScreen(
                                  course: _selectedCourse ?? 'Unknown Course',
                                  classTime: _selectedHour ?? 'Unknown Time',
                                ),
                              ),
                            );
                          }
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
      ),
    );
  }

  Widget _buildClassCard(String title, String timeRange) {
    bool isSelected = _selectedClass == title;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isSelected ? AppColors.accentColor : Colors.white,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedClass = title;
            _selectedShift = title.split('-')[0].trim();
            _selectedHour = timeRange;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                timeRange,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
