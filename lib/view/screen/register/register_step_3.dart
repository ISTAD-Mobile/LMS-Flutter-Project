import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:http/http.dart' as http;

class RegisterStep3 extends StatefulWidget {
  const RegisterStep3({super.key});

  @override
  _StudentAdmissionScreenState createState() => _StudentAdmissionScreenState();
}

class _StudentAdmissionScreenState extends State<RegisterStep3> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedShift;
  String? _selectedStudyProgram;
  String? _selectedDegree;
  String result = '';
  bool isLoading = false;
  final bool _isFormSubmitted = false;
  final shiftController = TextEditingController();
  final List<String> shiftOptions = [
    'Evening (Mon-Fri) | វេនយប់ (ចន្ទ - សុក្រ)',
    'Afternoon (Mon-Fri) | វេនរសៀល (ចន្ទ - សុក្រ)',
    'Morning (Mon-Fri) | វេនព្រឹក (ចន្ទ - សុក្រ)',];
  final TextEditingController _biographyController = TextEditingController();

  final studyProgramController = TextEditingController();
  final List<String> studyProgramOptions = [
    'Association of Information Technology',
    'Bachelor of Information and Technology'];
  final TextEditingController _studyProgramController = TextEditingController();

  final degreeController = TextEditingController();
  final List<String> degreeOptions = [
    'Bachelor Degree',
    'Association Degree',];
  final TextEditingController _degreeController = TextEditingController();

  Future<void> _stepThreeFormSubmit() async {
    try {
      final response = await http.post(
        Uri.parse('https://dev-flutter.cstad.edu.kh/api/v1/student-admissions'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'shift': _selectedShift,
          'address': _selectedStudyProgram,
          'degree': _selectedDegree,
        }),
      );

      // Print the raw response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        setState(() {
          result = 'ID: ${responseData['id']}\nName: ${responseData['name']}\nEmail: ${responseData['email']}';
        });
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.defaultGrayColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Student Admission',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
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
                const Text(
                  'Institute Information',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Shift',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: DropdownMenu<String>(
                    width: 398,
                    hintText: 'Select shift ',
                    errorText: _isFormSubmitted && _selectedShift == null ? 'Please select shift' : null,
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
                    controller: shiftController,
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
                    dropdownMenuEntries: shiftOptions.map((e) =>
                        DropdownMenuEntry(
                          value: e,
                          label: e,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.transparent),
                            foregroundColor: WidgetStateProperty.all(Colors.black),
                            textStyle: WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.hovered)) {
                                return const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                );
                              }
                              return const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              );
                            }),
                          ),
                        ),
                    ).toList(),
                    onSelected: (String? value) {
                      setState(() {
                        _selectedShift = value;
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    enableSearch: true,
                    requestFocusOnTap: true,
                    enableFilter: true,
                  ),
                ),
                const SizedBox(height: 20,),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Degree',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: DropdownMenu<String>(
                    width: 398,
                    hintText: 'Select Degree ',
                    errorText: _isFormSubmitted && _selectedDegree == null ? 'Please select Degree' : null,
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
                    controller: degreeController,
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
                    dropdownMenuEntries: degreeOptions.map((e) =>
                        DropdownMenuEntry(
                          value: e,
                          label: e,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.transparent),
                            foregroundColor: WidgetStateProperty.all(Colors.black),
                            textStyle: WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.hovered)) {
                                return const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                );
                              }
                              return const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              );
                            }),
                          ),
                        ),
                    ).toList(),
                    onSelected: (String? value) {
                      setState(() {
                        _selectedDegree = value;
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    enableSearch: true,
                    requestFocusOnTap: true,
                    enableFilter: true,
                  ),
                ),
                const SizedBox(height: 20,),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Study Program',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: DropdownMenu<String>(
                    width: 398,
                    hintText: 'Select Study Program ',
                    errorText: _isFormSubmitted && _selectedStudyProgram == null ? 'Please select Study Program' : null,
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
                    controller: studyProgramController,
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
                    dropdownMenuEntries: studyProgramOptions.map((e) =>
                        DropdownMenuEntry(
                          value: e,
                          label: e,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.transparent),
                            foregroundColor: WidgetStateProperty.all(Colors.black),
                            textStyle: WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.hovered)) {
                                return const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                );
                              }
                              return const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              );
                            }),
                          ),
                        ),
                    ).toList(),
                    onSelected: (String? value) {
                      setState(() {
                        _selectedStudyProgram = value;
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    enableSearch: true,
                    requestFocusOnTap: true,
                    enableFilter: true,
                  ),
                ),
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Biography (optional)',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _biographyController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: 'Enter your biography...',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey.shade300, width: 1),
                            ),
                          ),
                          child: const Text(
                            "Previous",
                            style: TextStyle(color: AppColors.defaultGrayColor),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await _stepThreeFormSubmit();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Submit', style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
