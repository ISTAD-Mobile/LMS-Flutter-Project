import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:flutter_typeahead/src/material/flutter_typeahead.dart';

import '../../../../data/color/color_screen.dart';

class EnrollStep3 extends StatefulWidget {
  // const EnrollStep3({Key? key}) : super(key: key);
  const EnrollStep3({super.key});
  @override
  _EnrollStep3State createState() => _EnrollStep3State();
}

class _EnrollStep3State extends State<EnrollStep3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _courses = ['Web design', 'Java', 'Block Chain', 'DevOps'];
  String? _selectedClass;
  String? _selectedCourse;
  bool _showCourseList = false;
  String? _selectedShift;
  String? _selectedHour;

  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void dispose() {
    _typeAheadController.dispose();
    super.dispose();
  }


  Widget _buildSelectionSummary() {
    if (_selectedCourse == null || _selectedClass == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
              _typeAheadController.clear();
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
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Enrollment Screen',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Course *',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildCourseSelector(),
                  const SizedBox(height: 20),
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
                        _buildClassCard('Morning-Weekend', '08:00 PM - 12:00 PM'),
                      ],
                    ),
                    if (_selectedClass != null) _buildSelectionSummary(),
                  ],
                  const SizedBox(height: 24),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Enroll')),
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

  Widget _buildCourseSelector() {
    return SizedBox(
      height: 55,
      // child: TypeAheadFormField<String>(  // Changed to TypeAheadFormField
      //   textFieldConfiguration: TextFieldConfiguration(
      //     controller: _typeAheadController,
      //     decoration: InputDecoration(
      //       hintText: "Select Course",
      //       border: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(10),
      //         borderSide: const BorderSide(color: Colors.grey),
      //       ),
      //       enabledBorder: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(10),
      //         borderSide: const BorderSide(color: Colors.grey),
      //       ),
      //       focusedBorder: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(10),
      //         borderSide: const BorderSide(color: Colors.blue),
      //       ),
      //       contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      //     ),
      //   ),
      //   suggestionsCallback: (pattern) async {  // Added async
      //     if (pattern.isEmpty) return [];
      //     return _courses
      //         .where((course) => course.toLowerCase().contains(pattern.toLowerCase()))
      //         .toList();
      //   },
      //   itemBuilder: (context, String suggestion) {  // Added type annotation
      //     return ListTile(
      //       title: Text(
      //         suggestion,
      //         style: const TextStyle(fontSize: 16, color: Colors.black),
      //       ),
      //     );
      //   },
      //   onSuggestionSelected: (String suggestion) {  // Added type annotation
      //     setState(() {
      //       _selectedCourse = suggestion;
      //       _typeAheadController.text = suggestion;
      //     });
      //   },
      //   suggestionsBoxBuilder: (context, suggestionsBox) {  // New way to style suggestions box
      //     return Container(
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(10),
      //         boxShadow: [
      //           BoxShadow(
      //             color: Colors.grey.withOpacity(0.2),
      //             spreadRadius: 2,
      //             blurRadius: 4,
      //             offset: const Offset(0, 2),
      //           ),
      //         ],
      //       ),
      //       child: suggestionsBox,
      //     );
      //   },
      //   noItemsFoundBuilder: (context) => const Padding(
      //     padding: EdgeInsets.all(8.0),
      //     child: Text(
      //       'No matches found',
      //       style: TextStyle(color: Colors.grey),
      //     ),
      //   ),
      //   validator: (value) {
      //     if (value == null || value.isEmpty) {
      //       return 'Please select a course';
      //     }
      //     return null;
      //   },
      // ),
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

