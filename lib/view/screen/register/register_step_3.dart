import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:http/http.dart' as http;
import 'package:lms_mobile/data/response/status.dart';
import 'package:lms_mobile/model/admission/admission_form.dart';
import 'package:provider/provider.dart';

import '../../../viewModel/admission/admission_viewmodel.dart';
import '../../../viewModel/admission/upload_image_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterStep3(),
    );
  }
}

class RegisterStep3 extends StatefulWidget {
  const RegisterStep3({super.key});

  @override
  _StudentAdmissionScreenState createState() => _StudentAdmissionScreenState();
}

class _StudentAdmissionScreenState extends State<RegisterStep3> {

  String? _selectedGender;
  final List<String> genderOptions = ['Female', 'Male', 'Other'];
  final bool _isFormSubmitted = false;
  final _formKey = GlobalKey<FormState>();
  final nameKhController = TextEditingController();
  final nameEnController = TextEditingController();
  final genderController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final contactNumberController = TextEditingController();
  final contactEmailController = TextEditingController();
  final contactHighSchoolController = TextEditingController();
  final contactContactNumberController = TextEditingController();
  final contactGuardianContactController = TextEditingController();
  final nameFatherController = TextEditingController();
  final fatherPhoneNumberController = TextEditingController();
  final nameMotherController = TextEditingController();
  final motherPhoneNumberController = TextEditingController();
  final associateController = TextEditingController();
  final studentNameController = TextEditingController();
  var imageId;

  String result = '';
  bool isLoading = false;
  String? selectedGender;
  String? selectedPlaceOfBirth;
  String? selectCurrentAddress;
  String? selectGuardianRelationship;
  String? selectGetToKnowIstad;
  File? _selectedUploadFormal;

  String? selectedClassStudent;
  String? selectedGrade;
  String? selectedDiplomaSession;
  String? _selectedClassStudent;
  final List<String> classStudentOptions = ['Science Class','Social Science Class'];
  final classStudentController = TextEditingController();
  String? _selectedGrade;
  final List<String> gradeOptions = [
    'Grade A',
    'Grade B',
    'Grade C',
    'Grade D',
    'Grade E',
    'Grade F',
    'Grade Auto',
    'Waiting for Results'];
  final gradeController = TextEditingController();
  String? _selectedDiplomaSession;
  final List<String> diplomaSessionOptions = [
    '2021',
    '2022',
    '2023',
    '2024',
    'Other'];
  final diplomaSessionController = TextEditingController();

  String? _selectedShift;
  String? _selectedStudyProgram;
  String? _selectedDegree;
  final shiftController = TextEditingController();

  final _admissionViewModel = AdmissionViewmodel();


  void _stepThreeFormSubmit() async {
    var admissionRequest = AdmissionRequest(
        nameEn: nameEnController.text,
        nameKh: nameKhController.text,
        gender: genderController.text,
        address: selectCurrentAddress,
        bacIiGrade: gradeController.text,
        birthPlace: selectedPlaceOfBirth,
        classStudent: selectedClassStudent,
        diplomaSession: selectedDiplomaSession,
        dob: _selectedBirthDate,
        email: contactEmailController.text,
        shiftAlias: shiftController.text,
        degreeAlias: degreeController.text,
        biography: _biographyController.text,
        studyProgramAlias: _studyProgramController.text,
        fatherName: nameFatherController.text,
        fatherPhoneNumber: fatherPhoneNumberController.text,
        guardianContact: contactGuardianContactController.text,
        guardianRelationShip: selectGuardianRelationship,
        highSchool: contactHighSchoolController.text,
        knownIstad: selectGetToKnowIstad,
        motherName: nameMotherController.text,
        motherPhoneNumber: motherPhoneNumberController.text,
        associate: associateController.text,
        studentName: studentNameController.text,
        // vocationTrainingIiiCertificate:
    );
    _admissionViewModel.postAdmission(admissionRequest);
  }

  @override
  void dispose() {
    nameKhController.dispose();
    nameEnController.dispose();
    genderController.dispose();
    selectCurrentAddress;
    gradeController.dispose();
    selectedPlaceOfBirth;
    selectedClassStudent;
    selectedDiplomaSession;
    _selectedBirthDate;
    contactEmailController.dispose();
    shiftController.dispose();
    degreeController.dispose();
    _biographyController.dispose();
    _studyProgramController.dispose();
    nameFatherController.dispose();
    fatherPhoneNumberController.dispose();
    contactGuardianContactController.dispose();
    selectGuardianRelationship;
    contactHighSchoolController.dispose();
    selectGetToKnowIstad;
    nameMotherController.dispose();
    motherPhoneNumberController.dispose();
    associateController.dispose();
    studentNameController.dispose();
    super.dispose();
  }



  File? _selectedHighCertificate;
  final ImagePicker _pickerSelectedHighCertificate = ImagePicker();
  final String selectHighCertificateUrl = "https://dev-flutter.cstad.edu.kh/api/v1/medias/upload-single";

  Future<void> _pickImageHighCertificate(ImageSource source) async {
    final XFile? pickedImage = await _pickerSelectedHighCertificate.pickImage(source: source);
    if (pickedImage != null) {
      final pickedFile = File(pickedImage.path);
      if (await pickedFile.length() > 10 * 1024 * 1024) {
        setState(() {
          result = 'File size should not exceed 10MB';
        });
      } else {
        setState(() {
          _selectedHighCertificate = pickedFile;
          result = '';
        });
        _uploadImageHighCertificate(_selectedHighCertificate!);
      }
    }
  }

  Future<void> _uploadImageHighCertificate(File imageFile) async {
    try {
      var uri = Uri.parse(selectHighCertificateUrl);
      var request = http.MultipartRequest('POST', uri)
        ..headers['Content-Type'] = 'multipart/form-data'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 201) {
        setState(() {
          result = 'Image uploaded successfully!';
        });
      } else {
        setState(() {
          result = 'Failed to upload image. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error uploading image: $e';
      });
    }
  }

  Future<void> _stepTwoFormSubmit() async {
    try {
      final response = await http.post(
        Uri.parse('https://dev-flutter.cstad.edu.kh/api/v1/student-admissions'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'classStudent': selectedClassStudent,
          'diplomaSession': selectedDiplomaSession,
          'bacIiGrade': selectedGrade,
        }),
      );

      // Print the raw response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 201) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        setState(() {
          result = 'ID: ${responseData['id']}\nName: ${responseData['name']}\nEmail: ${responseData['email']}';
        });
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }


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

  final ImagePicker _pickerUploadFormal = ImagePicker();
  final String uploadFormalUrl = "https://dev-flutter.cstad.edu.kh/api/v1/medias/upload-single";

  Future<void> _pickImageUploadFormal(ImageSource source) async {
    final XFile? pickedImage = await _pickerUploadFormal.pickImage(source: source);
    if (pickedImage != null) {
      final pickedFile = File(pickedImage.path);
      if (await pickedFile.length() > 10 * 1024 * 1024) {
        setState(() {
          result = 'File size should not exceed 10MB';
        });
      } else {
        setState(() {
          _selectedUploadFormal = pickedFile;
          result = '';
        });
        _uploadImageFormal(_selectedUploadFormal!);
      }
    }
  }

  // Function to upload the image
  Future<void> _uploadImageFormal(File imageFile) async {
    try {
      var uri = Uri.parse(uploadFormalUrl);
      // Create a multipart request
      var request = http.MultipartRequest('POST', uri)
        ..headers['Content-Type'] = 'multipart/form-data'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 201) {
        setState(() {
          result = 'Image uploaded successfully!';
        });
      } else {
        setState(() {
          result = 'Failed to upload image. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error uploading image: $e';
      });
    }
  }

  File? _uploadIdentity;
  final ImagePicker _pickerSelectUploadIdentity = ImagePicker();
  final String selectUploadIdentiryUrl = "https://dev-flutter.cstad.edu.kh/api/v1/medias/upload-single";

  Future<void> _pickUploadIdentity(ImageSource source) async {
    final XFile? pickedImage = await _pickerSelectUploadIdentity.pickImage(source: source);
    if (pickedImage != null) {
      final pickedFile = File(pickedImage.path);
      if (await pickedFile.length() > 10 * 1024 * 1024) {
        setState(() {
          result = 'File size should not exceed 10MB';
        });
      } else {
        setState(() {
          _uploadIdentity = pickedFile;
          result = '';
        });
        _uploadImageIndentity(_uploadIdentity!);
      }
    }
  }

  Future<void> _uploadImageIndentity(File imageFile) async {
    try {
      var uri = Uri.parse(selectUploadIdentiryUrl);
      var request = http.MultipartRequest('POST', uri)
        ..headers['Content-Type'] = 'multipart/form-data'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 201) {
        setState(() {
          result = 'Image uploaded successfully!';
        });
      } else {
        setState(() {
          result = 'Failed to upload image. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error uploading image: $e';
      });
    }
  }


  // Form fields
  static const int _minAge = 16;
  static const int _maxAge = 100;
  DateTime? _selectedBirthDate;
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

  bool isPicked = false;
  var imageFile;
  final _imageViewModel = ImageViewModel();


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
                _buildTextField(
                  label: 'Name (KH) *',
                  controller: nameKhController,
                  hintText: 'លាង ណៃគីម',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name in Khmer';
                    }

                    final khmerRegex = RegExp(r'^[\u1780-\u17FF\s]+$');
                    if (!khmerRegex.hasMatch(value)) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Name (EN) *',
                  controller: nameEnController,
                  hintText: 'Leang Naikim',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    String pattern = r'^[a-zA-Z\s]+$';
                    RegExp regex = RegExp(pattern);

                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid name (letters and spaces only)';
                    }

                    return null;
                  },
                ),

                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Gender',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
                    hintText: 'Select Gender',
                    errorText: _isFormSubmitted && _selectedGender == null ? 'Please select gender' : null,
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
                    controller: genderController,
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
                    dropdownMenuEntries: genderOptions.map((e) =>
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
                        _selectedGender = value;
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    enableSearch: true,
                    requestFocusOnTap: true,
                    enableFilter: true,
                  ),
                ),
                const SizedBox(height: 15,),
                _buildFormField(
                  label: 'Date of Birth ',
                  child: GestureDetector(
                    onTap: _showDatePicker,
                    child: Container(
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
                    ),
                  ),
                ),
                _buildTextField(
                  label: 'Contact Number (Telegram) *',
                  controller: contactNumberController,
                  keyboardType: TextInputType.phone,
                  hintText: '092382489',
                  validator: (value) {
                    // Check if the value is empty
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    // Check if the value matches a valid phone number pattern (e.g., 10 digits)
                    String phonePattern = r'^[0-9]{9,15}$'; // Adjust for your specific phone format
                    RegExp regex = RegExp(phonePattern);

                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }

                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Email *',
                  controller: contactEmailController,
                  hintText: 'student.istad@gmail.com',
                  validator: (value) {
                    // Check if the value is empty
                    keyboardType: TextInputType.emailAddress;
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      const emailPattern = r'^[^@]+@[^@]+\.[^@]+';
                      final regex = RegExp(emailPattern);
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    };
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'High School *',
                  controller: contactHighSchoolController,
                  hintText: 'Bak Touk High School',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildDropdownField(
                  label: 'Place of Birth *',
                  value: selectedPlaceOfBirth,
                  hintText: 'Select a province',
                  items: [
                    'Select a province',
                    'Phnom Penh',
                    'Siem Reap',
                    'Battambang',
                    'Kampot',
                    'Kandal',
                    'Kep',
                    'Koh Kong',
                    'Banteay Meanchey',
                    'Kampong Cham',
                    'Kampong Speu',
                    'Kampong Thom',
                    'Kratie',
                    'Mondulkiri',
                    'Oddar Meanchey',
                    'Peilin',
                    'Preah Sihanouk',
                    'Preah Vihear',
                    'Prey Veng',
                    'Pursat',
                    'Rotanakiri',
                    'Stung Treng',
                    'Svay Rieng',
                    'Takeo',
                    'Tboung Khmum',
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedPlaceOfBirth = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildDropdownField(
                  label: 'Current Address *',
                  value: selectCurrentAddress,
                  hintText: 'Phnom Penh',
                  items: [
                    'Select a province',
                    'Phnom Penh',
                    'Siem Reap',
                    'Battambang',
                    'Kampot',
                    'Kandal',
                    'Kep',
                    'Koh Kong',
                    'Banteay Meanchey',
                    'Kampong Cham',
                    'Kampong Speu',
                    'Kampong Thom',
                    'Kratie',
                    'Mondulkiri',
                    'Oddar Meanchey',
                    'Peilin',
                    'Preah Sihanouk',
                    'Preah Vihear',
                    'Prey Veng',
                    'Pursat',
                    'Rotanakiri',
                    'Stung Treng',
                    'Svay Rieng',
                    'Takeo',
                    'Tboung Khmum',
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectCurrentAddress = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty ||
                        value == 'Select a province') {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Guardian Contact *',
                  controller: contactGuardianContactController,
                  keyboardType: TextInputType.phone,
                  hintText: '092382489',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    String phonePattern = r'^[0-9]{9,15}$';
                    RegExp regex = RegExp(phonePattern);

                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }

                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Father Name *',
                  controller: nameFatherController,
                  hintText: 'Ooh sehun',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Father Contact *',
                  controller: fatherPhoneNumberController,
                  keyboardType: TextInputType.phone,
                  hintText: '093847843',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    String phonePattern = r'^[0-9]{9,15}$';
                    RegExp regex = RegExp(phonePattern);

                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }

                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Mother Name *',
                  controller: nameMotherController,
                  hintText: 'Ooh Susu',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Mother Contact *',
                  controller: motherPhoneNumberController,
                  keyboardType: TextInputType.phone,
                  hintText: '098398394',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    String phonePattern = r'^[0-9]{9,15}$';
                    RegExp regex = RegExp(phonePattern);

                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }

                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Associate *',
                  controller: associateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'StudentName *',
                  controller: studentNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildDropdownField(
                  label: 'Guardian Relationship *',
                  value: selectGuardianRelationship,
                  hintText: 'Select Guardian Relationship',
                  items: [
                    'Select Guardian Relationship',
                    'Mother',
                    'Father',
                    'Grandmother',
                    'Grandfather',
                    'Aunt',
                    'Uncle',
                    'Elder Sister',
                    'Elder Brother',
                    'Legal Guardian',
                    'Cousin',
                    'Sibling',
                    'Other',
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectGuardianRelationship = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty ||
                        value == 'Select Guardian Relationship') {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildDropdownField(
                  label: 'Get to know ISTAD through: *',
                  value: selectGetToKnowIstad,
                  hintText: 'Select how you knew about ISTAD',
                  items: [
                    'Select how you knew about ISTAD',
                    'Ministry, Provincial Department',
                    'Teacher',
                    'Senior Student',
                    'Friends',
                    'Facebook',
                    'Instagram',
                    'YouTube',
                    'Television',
                    'Radio',
                    'ISTAD Website',
                    'Other'
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectGetToKnowIstad = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 'Select how you knew about ISTAD') {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Sample Photo",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 135,
                          height: 160,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey),
                            color: Colors.grey.shade200,
                          ),
                          child: Image.asset(
                            'assets/images/cher_muyleang.png',
                            fit: BoxFit.cover,
                            // color: AppColors.defaultGrayColor,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // const Text(
                //   'Upload Formal Picture',
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //     color: AppColors.primaryColor,
                //   ),
                // ),
                // const SizedBox(height: 8),
                // GestureDetector(
                //   onTap: () => _pickImageUploadFormal(ImageSource.gallery),
                //   child: Container(
                //     width: double.infinity,
                //     height: 200,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Colors.grey.shade400,
                //         width: 1.0,
                //       ),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: _selectedUploadFormal == null
                //         ? const Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           Icons.cloud_download_outlined,
                //           color: AppColors.primaryColor,
                //           size: 40,
                //         ),
                //         SizedBox(height: 5),
                //         Text(
                //           'Avatar',
                //           style: TextStyle(color: AppColors.defaultBlackColor),
                //         ),
                //         SizedBox(height: 10),
                //         Text(
                //           "Select a file or drag and drop here",
                //           style: TextStyle(
                //             color: AppColors.defaultBlackColor,
                //             fontSize: 13,
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //         SizedBox(height: 10),
                //         Text(
                //           "JPG, PNG or PDF, file size no more than 10MB",
                //           style: TextStyle(color: Colors.grey, fontSize: 12),
                //           textAlign: TextAlign.center,
                //         ),
                //       ],
                //     )
                //         : ClipRRect(
                //       borderRadius: BorderRadius.circular(8),
                //       child: Image.file(
                //         _selectedUploadFormal!,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ChangeNotifierProvider(
                        create: (context) => _imageViewModel,
                        child: Consumer<ImageViewModel>(
                          builder: (context, viewModel, _) {
                            if (viewModel.response.status == null) {
                              return InkWell(
                                onTap: () {
                                  _getImageFromSource(source: 'gallery');
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: _uploadIdentity == null
                                      ? const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cloud_download_outlined,
                                        color: AppColors.primaryColor,
                                        size: 40,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Select a file or drag and drop here',
                                        style: TextStyle(color: AppColors.defaultBlackColor),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "JPG, PNG or PDF, file size no more than 10MB",
                                        style: TextStyle(color: Colors.grey, fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      _uploadIdentity!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }
                            switch (viewModel.response.status!) {
                              case Status.LOADING:
                                return const Center(child: CircularProgressIndicator());
                              case Status.COMPLETED:
                                imageId = viewModel.response.data[0].id;
                                return InkWell(
                                  onTap: () {
                                    _getImageFromSource(source: 'gallery');
                                  },
                                  child: SizedBox(
                                    width: 350,
                                    height: 350,
                                    child: Image.network('https://dev-flutter.cstad.edu.kh/api/v1${viewModel.response.data.uri!}'),
                                  ),
                                );
                              case Status.ERROR:
                                return Text(viewModel.response.message!);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Class Student',
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
                SizedBox(height: 10,),
                SizedBox(
                  width: double.infinity,
                  child: DropdownMenu<String>(
                    width: 398,
                    hintText: 'Select Class ',
                    errorText: _isFormSubmitted && _selectedClassStudent == null ? 'Please select class' : null,
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
                    controller: classStudentController,
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
                    dropdownMenuEntries: classStudentOptions.map((e) =>
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
                        _selectedClassStudent = value;
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    enableSearch: true,
                    requestFocusOnTap: true,
                    enableFilter: true,
                  ),
                ),
                SizedBox(height: 10,),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Grade (Optional)',
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
                    hintText: 'Select a grade ',
                    errorText: _isFormSubmitted && _selectedGrade == null ? 'Please select a grade' : null,
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
                    controller: gradeController,
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
                    dropdownMenuEntries: gradeOptions.map((e) =>
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
                        _selectedGrade = value;
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    enableSearch: true,
                    requestFocusOnTap: true,
                    enableFilter: true,
                  ),
                ),
                SizedBox(height: 10,),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Class Student',
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
                    hintText: 'Select Diploma Session',
                    errorText: _isFormSubmitted && _selectedDiplomaSession == null ? 'Please select diploma session' : null,
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
                    controller: diplomaSessionController,
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
                    dropdownMenuEntries: diplomaSessionOptions.map((e) =>
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
                        _selectedDiplomaSession = value;
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    enableSearch: true,
                    requestFocusOnTap: true,
                    enableFilter: true,
                  ),
                ),
                SizedBox(height: 10,),
                // const Text(
                //   'High Certificate (Optional)',
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //     color: AppColors.primaryColor,
                //   ),
                // ),
                // const SizedBox(height: 8),
                // GestureDetector(
                //   onTap: () => _showImageSourceOptions(context),
                //   child: Container(
                //     width: double.infinity,
                //     height: 200,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Colors.grey.shade400,
                //         width: 1.0,
                //       ),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: _selectedHighCertificate == null
                //         ? const Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(Icons.cloud_download_outlined,
                //             color: AppColors.primaryColor, size: 40),
                //         SizedBox(height: 5),
                //         Text(
                //           'Select a file or drag and drop here',
                //           style: TextStyle(color: AppColors.defaultBlackColor),
                //         ),
                //         SizedBox(height: 10),
                //         Text(
                //           "Please provide a BacII certificate (Cambodia National Exam Certificate), exam result or equivalent professional degree",
                //           style: TextStyle(
                //             color: AppColors.defaultBlackColor,
                //             fontSize: 13,
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //         SizedBox(height: 10),
                //         Text(
                //           "JPG, PNG or PDF, file size no more than 10MB",
                //           style: TextStyle(color: Colors.grey, fontSize: 12),
                //           textAlign: TextAlign.center,
                //         ),
                //       ],
                //     )
                //         : ClipRRect(
                //       borderRadius: BorderRadius.circular(8),
                //       child: Image.file(
                //         _selectedHighCertificate!,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 10,),
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
                        ChangeNotifierProvider(
                          create: (context) => _admissionViewModel,
                          child: Consumer<AdmissionViewmodel>(
                            builder: (ctx, viewModel,_){
                              if (viewModel.response.status == null){
                                return ElevatedButton(
                                  onPressed: () { _stepThreeFormSubmit();},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Submit', style: TextStyle(color: Colors.white),),
                                );
                              }
                              switch(viewModel.response.status!){
                              case Status.LOADING:
                                  print('Loading...');
                                  return const Center(child: CircularProgressIndicator(),);
                                case Status.COMPLETED:
                                  print('API Response: ${viewModel.response.data}');
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Post Successful'))
                                    );
                                  });
                                  return ElevatedButton(
                                    onPressed: () { _stepThreeFormSubmit();},
                                      style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      ),
                                      ),
                                      child: const Text('Submit', style: TextStyle(color: Colors.white),),
                                    );
                                case Status.ERROR:
                                  print('Error: ${viewModel.response.message}');
                                  return Text(viewModel.response.message!);
                              }
                            }
                          ),
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

  _getImageFromSource({source}) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: source == "gallery" ? ImageSource.gallery : ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      print('Picked image: ${File(pickedFile.path)}');
      _imageViewModel.uploadFileImage(pickedFile.path);
    }
  }
}


void _showImageSourceOptions(BuildContext context) async {
  final pickedSource = await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Camera'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              title: const Text('Gallery'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      );
    },
  );

}


Widget _buildTextField({
  required String label,
  required TextEditingController controller,
  String? hintText,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.endsWith('*') ? label.substring(0, label.length - 1) : label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            children: [
              if (label.endsWith('*'))
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400,fontFamily: 'NotoSansKhmer'),
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFormField({
  required String label,
  required Widget child,
}) {
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


Widget _buildDropdownField({
  required String label,
  required String? value,
  required List<String> items,
  String? hintText,
  required void Function(String?) onChanged,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.endsWith('*') ? label.substring(0, label.length - 1) : label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            children: [
              if (label.endsWith('*'))
                const TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
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
            menuHeight: 400,
            hintText: hintText,
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            menuStyle: MenuStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            initialSelection: value,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
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
            dropdownMenuEntries: items.map((e) =>
                DropdownMenuEntry(
                  value: e,
                  label: e,
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
                    foregroundColor: const WidgetStatePropertyAll(Colors.black),
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
            onSelected: onChanged,
            enableSearch: true,
            requestFocusOnTap: true,
            enableFilter: true,
            errorText: validator?.call(value),
          ),
        ),
      ],
    ),
  );

}


