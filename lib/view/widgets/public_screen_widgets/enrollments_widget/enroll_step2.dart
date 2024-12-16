import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'enroll_step3.dart';

class EnrollStep2 extends StatefulWidget {
  const EnrollStep2({super.key});

  @override
  _CourseEnrollForm createState() => _CourseEnrollForm();
}

class _CourseEnrollForm extends State<EnrollStep2> {
  final _formKey = GlobalKey<FormState>();

  // Country dropdown
  final List<String> countryOptions = ['Cambodia', 'English', 'Other'];
  bool _isFormSubmitted = false;
  String? _selectedCountry;

  // Birth Date
  DateTime? _selectedBirthDate;

  // Education dropdown
  final List<String> educationOptions = [
    'High School',
    'Bachelor',
    'Master',
    'PhD',
    'Other'
  ];
  String? _selectedEducation;

  // University dropdown
  final List<String> universityOptions = [
    'University of Cambodia',
    'Royal University of Phnom Penh',
    'Norton University',
    'Other'
  ];
  String? _selectedUniversity;

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
        errorText:
        _isFormSubmitted && selectedValue == null ? 'Please $hint' : null,
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
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        dropdownMenuEntries: options
            .map(
              (e) => DropdownMenuEntry(
            value: e,
            label: e,
          ),
        )
            .toList(),
        onSelected: (String? value) {
          onSelected(value);
          FocusManager.instance.primaryFocus?.unfocus();
        },
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
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
                // Birth Date Field
                const Text(
                  'Date of Birth',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedBirthDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedBirthDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedBirthDate != null
                              ? '${_selectedBirthDate!.year}-${_selectedBirthDate!.month}-${_selectedBirthDate!.day}'
                              : 'Select Date of Birth',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.calendar_today, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                if (_isFormSubmitted && _selectedBirthDate == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Please select date of birth',
                      style: TextStyle(color: Colors.red[700], fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 15),

                // Country address Field
                const Text(
                  'Country address',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildDropdownMenu(
                  hint: 'Select Country',
                  options: countryOptions,
                  selectedValue: _selectedCountry,
                  onSelected: (value) {
                    setState(() {
                      _selectedCountry = value;
                    });
                  },
                ),
                const SizedBox(height: 15),

                // Education Field
                const Text(
                  'Education',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildDropdownMenu(
                  hint: 'Select Education',
                  options: educationOptions,
                  selectedValue: _selectedEducation,
                  onSelected: (value) {
                    setState(() {
                      _selectedEducation = value;
                    });
                  },
                ),
                const SizedBox(height: 15),

                // University Field
                const Text(
                  'University',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildDropdownMenu(
                  hint: 'Select University',
                  options: universityOptions,
                  selectedValue: _selectedUniversity,
                  onSelected: (value) {
                    setState(() {
                      _selectedUniversity = value;
                    });
                  },
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                      ),
                      child: const Text(
                        'Previous',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    // Next Button
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isFormSubmitted = true;
                        });
                        if (_formKey.currentState!.validate() &&
                            _selectedBirthDate != null &&
                            _selectedCountry != null &&
                            _selectedEducation != null &&
                            _selectedUniversity != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EnrollStep3()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
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
  }
}