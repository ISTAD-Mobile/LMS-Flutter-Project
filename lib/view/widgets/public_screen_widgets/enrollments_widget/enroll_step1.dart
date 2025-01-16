import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/viewModel/enroll/enrollment_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../screen/homeScreen/course/course_details_screen.dart';
import 'enroll_step2.dart';

class EnrollStep1 extends StatefulWidget {
  const EnrollStep1({super.key,});

  @override
  _EnrollStep1 createState() => _EnrollStep1();
}

class _EnrollStep1 extends State<EnrollStep1> {

  String? fullName;
  String? gender;
  String? phone;
  String? email;

  bool _isFormSubmitted = false;
  String result = '';
  bool isLoading = false;
  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = false;

  bool _validateForm() {
    return _fullNameController.text.isNotEmpty &&
        _selectedGender != null &&
        phoneNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty;
  }

  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  final List<String> genderOptions = ['Female', 'Male', 'Other'];

  final List<String> _previousNames = [];
  final TextEditingController _fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    _focusNode.addListener(_onFocusChange);
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName');
      _selectedGender = prefs.getString('gender');
      phone = prefs.getString('phone');
      email = prefs.getString('email');
    });
  }

  Future<void> _saveStep1Data() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fullName', fullName?.toString() ?? '');
    prefs.setString('gender', gender ?? '');
    prefs.setString('phone', phone ?? '');
    prefs.setString('email', email ?? '');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    phoneNumberController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isExpanded = _focusNode.hasFocus;
    });
  }

  void _addToPreviousNames(String value) {
    if (value.isNotEmpty && !_previousNames.contains(value)) {
      setState(() {
        _previousNames.insert(0, value);
        if (_previousNames.length > 5) {
          _previousNames.removeLast();
        }
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
            // Navigate to the screen detail
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => CourseDetailsPage(),
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
                const Text(
                  'Please fill in form for enrollmentRequest',
                  style: TextStyle(
                    color: AppColors.defaultGrayColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
                // Full Name Field
                const Text(
                  'Full Name',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _fullNameController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Chan SomNan',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {}); // Trigger rebuild to update suggestions
                  },
                  onFieldSubmitted: (value) {
                    _addToPreviousNames(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    final nameRegExp = RegExp(r"^[a-zA-Z\s\-']+$");
                    if (!nameRegExp.hasMatch(value)) {
                      return 'Please enter a valid name (letters, spaces, hyphens, and apostrophes only)';
                    }
                    return null;
                  },
                ),
                if (_isExpanded && _fullNameController.text.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    child: Column(
                      children: _previousNames
                          .where((name) => name.toLowerCase().startsWith(_fullNameController.text.toLowerCase()))
                          .map((name) => ListTile(
                        title: Text(name),
                        onTap: () {
                          setState(() {
                            _fullNameController.text = name;
                            _fullNameController.selection = TextSelection.fromPosition(
                              TextPosition(offset: _fullNameController.text.length),
                            );
                          });
                          _focusNode.unfocus();
                        },
                      ))
                          .toList(),
                    ),
                  ),
                const SizedBox(height: 15),
                // Email Field
                const Text(
                  'Email',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    const emailPattern = r'^[^@]+@[^@]+\.[^@]+';
                    final regex = RegExp(emailPattern);
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Gender Field
                const Text(
                  'Gender',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
                const SizedBox(height: 15),
                // Phone Number Field
                const Text(
                  'Phone Number',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    hintText: '+855123456789',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    final phoneRegExp = RegExp(r'^\+?[0-9]{9,14}$');
                    if (!phoneRegExp.hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 26),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() => _isFormSubmitted = true);
                        if (_formKey.currentState!.validate() && _validateForm()) {
                          await _saveStep1Data();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EnrollStep2()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please complete the form')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.defaultWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}