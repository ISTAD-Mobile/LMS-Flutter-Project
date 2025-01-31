import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/screen/register/register_step_3.dart';
import 'package:lms_mobile/viewModel/admission/study_program_alas.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../viewModel/enroll/current_address_view_model.dart';
import '../../../viewModel/enroll/place_of_birth_view_model.dart';

class RegisterStep2 extends StatefulWidget {

  @override
  _StudentAdmissionFormState createState() => _StudentAdmissionFormState();
}

class _StudentAdmissionFormState extends State<RegisterStep2> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool _isFormSubmitted = false;
  String? _selectedCurrentAddress;
  String? _selectedStudyProgramAlas;
  String? _selectedPlaceOfBirth;

  final fatherController = TextEditingController();
  final fatherNumberController = TextEditingController();
  final motherController = TextEditingController();
  final motherNumberController = TextEditingController();
  final nameOfHighSchoolController = TextEditingController();

  bool _validateForm() {
    // Print the state of each required field
    print('Place of Birth: $_selectedPlaceOfBirth');
    print('Current Address: $_selectedCurrentAddress');
    print('Study Program: $_selectedStudyProgramAlas');
    print('Father Name: ${fatherController.text.trim()}');
    print('Father Phone: ${fatherNumberController.text.trim()}');
    print('Mother Name: ${motherController.text.trim()}');
    print('Mother Phone: ${motherNumberController.text.trim()}');
    print('High School: ${nameOfHighSchoolController.text.trim()}');

    if (!_formKey.currentState!.validate()) {
      print('Form validation failed');
      return false;
    }

    return _selectedPlaceOfBirth != null &&
        _selectedCurrentAddress != null &&
        _selectedStudyProgramAlas != null &&
        fatherController.text.trim().isNotEmpty &&
        fatherNumberController.text.trim().isNotEmpty &&
        motherController.text.trim().isNotEmpty &&
        motherNumberController.text.trim().isNotEmpty &&
        nameOfHighSchoolController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    Future.microtask(() {
      context.read<PlaceOfBirthViewModel>().fetchPlaceOfBlogs();
      context.read<CurrentAddressViewModel>().fetchCurrentAddressBlogs();
      context.read<StudyProgramAlasViewModel>().fetchAllStudyPrograms();
    });
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fatherController.text = prefs.getString('fatherName') ?? '';
      fatherNumberController.text = prefs.getString('fatherPhoneNumber') ?? '';
      motherController.text = prefs.getString('motherName') ?? '';
      motherNumberController.text = prefs.getString('motherPhoneNumber') ?? '';
      nameOfHighSchoolController.text = prefs.getString('highSchool') ?? '';

      _selectedPlaceOfBirth = prefs.getString('placeOfBirth') ?? ''; // Provide a default value
      _selectedCurrentAddress = prefs.getString('address') ?? ''; // Provide a default value
      _selectedStudyProgramAlas = prefs.getString('studyProgramAlias') ?? ''; // Provide a default value
      print("when load data save ${_selectedStudyProgramAlas}");

    });
  }

  Future<void> _saveStep2DataAdmission() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('address', _selectedCurrentAddress ?? '');
    prefs.setString('placeOfBirth', _selectedPlaceOfBirth ?? '');
    prefs.setString('studyProgramAlias', _selectedStudyProgramAlas ?? '');

    prefs.setString('fatherName', fatherController.text);
    prefs.setString('fatherPhoneNumber', fatherNumberController.text);
    prefs.setString('motherName', motherController.text);
    prefs.setString('motherPhoneNumber', motherNumberController.text);
    prefs.setString('highSchool', nameOfHighSchoolController.text);

    // print("Address: ${_selectedCurrentAddress ?? ''}");
    // print("Place of Birth: ${_selectedPlaceOfBirth ?? ''}");
    // print("Study Program Alias: ${_selectedStudyProgramAlas ?? ''}");
    // print("Father Name: ${fatherController.text}");
    // print("Father Phone Number: ${fatherNumberController.text}");
    // print("Mother Name: ${motherController.text}");
    // print("Mother Phone Number: ${motherNumberController.text}");
    // print("High School: ${nameOfHighSchoolController.text}");
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
        errorText: _isFormSubmitted && selectedValue == null ? 'ត្រូវការជ្រើសរើស' : null,
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
          hintStyle: TextStyle(
            fontSize: 15,
            color: selectedValue == null || selectedValue.isEmpty ? Colors.grey : Colors.black, // Change hint color dynamically
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        dropdownMenuEntries: options.map((e) {
          return DropdownMenuEntry(
            value: e,
            label: e,
          );
        }).toList(),
        onSelected: onSelected,
      ),
    );
  }
  Widget _buildFormField(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.endsWith('')
                ? label.substring(0, label.length - 1)
                : label,
            style: const TextStyle(
              fontSize: 17,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            children: [
              if (label.endsWith(''))
                const TextSpan(
                  text: ' ',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        child,
        const SizedBox(height: 15),
      ],
    );
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
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
          ),
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
                  'ពត៌មានបន្ថែម',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansKhmer',
                  ),
                ),
                const SizedBox(height: 20,),
                _buildTextField(
                  label: 'ឪពុកឈ្មោះ ',
                  controller: fatherController,
                  hintText: 'ដារ៉ា ផាន់',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'ត្រូវការបំពេញ';
                    }
                    return null;
                  },
                ),

                _buildTextField(
                  label: 'លេខទូរស័ព្ទឪពុក (បើមាន) ',
                  controller: fatherNumberController,
                  hintText: '0983728749',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'ត្រូវការបំពេញ';
                    }
                    String phonePattern = r'^[0-9]{9,15}$';
                    RegExp regex = RegExp(phonePattern);
                    if (!regex.hasMatch(value)) {
                      return 'ត្រូវការបំពេញលេខទូរស័ព្ទត្រឹមត្រូវ';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                    label: 'ម្តាយឈ្មោះ ',
                    controller: motherController,
                    hintText: 'សុជា គីម'
                ),
                _buildTextField(
                    label: 'លេខទូរស័ព្ទម្ដាយ (បើមាន) ',
                    controller: motherNumberController,
                    hintText: '0963762849',
                  keyboardType: TextInputType.phone,
                ),
                _buildTextField(
                    label: 'ឈ្មោះសាលារៀនរបស់ប្អូន ',
                    controller: nameOfHighSchoolController,
                    hintText: 'វិទ្យាល័យបាក់ទូក'
                ),
                _buildFormField(
                  'មកពីខេត្ត/ក្រុង ',
                  Consumer<PlaceOfBirthViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: _selectedPlaceOfBirth?.isNotEmpty == true
                          ? _selectedPlaceOfBirth!
                          : 'សូមជ្រើសរើសខេត្ត/ក្រុង',
                      options: viewModel.placeOfBirthList,
                      selectedValue: _selectedPlaceOfBirth,
                      onSelected: (value) async {
                        setState(() {
                          _selectedPlaceOfBirth = value;
                        });

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('place Address', value ?? '');
                      },
                    ),
                  ),
                ),
                _buildFormField(
                  'អាសយដ្ឋានបច្ចុប្បន្ន ',
                  Consumer<CurrentAddressViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: _selectedCurrentAddress?.isNotEmpty == true
                          ? _selectedCurrentAddress!
                          : 'សូមជ្រើសរើសខេត្ត/ក្រុង',
                      options: viewModel.currentAddressList,
                      selectedValue: _selectedCurrentAddress,
                      onSelected: (value) async {
                        setState(() {
                          _selectedCurrentAddress = value;
                        });

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('current Address', value ?? '');
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
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
                          "ថយក្រោយ",
                          style: TextStyle(color: AppColors.defaultGrayColor),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() => _isFormSubmitted = true);
                          if (_formKey.currentState!.validate() && _validateForm()) {
                            await _saveStep2DataAdmission();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterStep3()),
                            );
                          } else {
                            // Create a detailed error message
                            String missingFields = '';
                            if (_selectedPlaceOfBirth == null) missingFields += '\n- មកពីខេត្ត/ក្រុង';
                            if (_selectedCurrentAddress == null) missingFields += '\n- អាសយដ្ឋានបច្ចុប្បន្ន';
                            if (_selectedStudyProgramAlas == null) missingFields += '\n- កម្មវិធីសិក្សា';
                            if (fatherController.text.trim().isEmpty) missingFields += '\n- ឪពុកឈ្មោះ';
                            if (fatherNumberController.text.trim().isEmpty) missingFields += '\n- លេខទូរស័ព្ទឪពុក';
                            if (motherController.text.trim().isEmpty) missingFields += '\n- ម្តាយឈ្មោះ';
                            if (motherNumberController.text.trim().isEmpty) missingFields += '\n- លេខទូរស័ព្ទម្ដាយ';
                            if (nameOfHighSchoolController.text.trim().isEmpty) missingFields += '\n- ឈ្មោះសាលារៀន';

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('សូមបំពេញព័ត៌មានដែលនៅខ្វះខាត:$missingFields'),
                                duration: const Duration(seconds: 5),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'បន្ទាប់',
                          style: TextStyle(fontSize: 16, color: AppColors.defaultWhiteColor),
                        ),
                      ),
                    ],
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
              text: label.endsWith('')
                  ? label.substring(0, label.length - 1)
                  : label,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              children: [
                if (label.endsWith(''))
                  const TextSpan(
                    text: ' ',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NotoSansKhmer'),
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
                borderSide: const BorderSide(color: AppColors.primaryColor,width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red,width: 2.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
