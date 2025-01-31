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

  final List<String> gradeOptions = ['Grade A','Grade B'];

  String? _selectedGrade;
  String? _selectedCurrentAddress;
  String? _selectedStudyProgramAlas;

  final fatherController = TextEditingController();
  final fatherNumberController = TextEditingController();
  final motherController = TextEditingController();
  final motherNumberController = TextEditingController();
  final nameOfHighSchoolController = TextEditingController();

  bool _validateForm() {
    return
      _selectedGrade != null  &&
          _selectedCurrentAddress != null &&
          _selectedStudyProgramAlas != null &&
      fatherController.text.isNotEmpty &&
        fatherNumberController.text.isNotEmpty &&
        motherController.text.isNotEmpty &&
        motherNumberController.text.isNotEmpty &&
        nameOfHighSchoolController.text.isNotEmpty
    ;
  }

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    Future.microtask(() {
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

      _selectedGrade = prefs.getString('bacIiGrade');
      _selectedCurrentAddress = prefs.getString('address');
      _selectedStudyProgramAlas = prefs.getString('studyProgramAlias');

    });
  }

  Future<void> _saveStep2DataAdmission() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('address', _selectedCurrentAddress ?? '');
    prefs.setString('bacIiGrade', _selectedGrade ?? '');
    prefs.setString('studyProgramAlias', _selectedStudyProgramAlas ?? '');

    prefs.setString('fatherName', fatherController.text);
    prefs.setString('fatherPhoneNumber', fatherNumberController.text);
    prefs.setString('motherName', motherController.text);
    prefs.setString('motherPhoneNumber', motherNumberController.text);
    prefs.setString('highSchool', nameOfHighSchoolController.text);

    // await prefs.remove('fatherName');
    // await prefs.remove('fatherPhoneNumber');
    // await prefs.remove('motherName');
    // await prefs.remove('motherPhoneNumber');
    // await prefs.remove('highSchool');

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

    bool _isFormSubmitted = false;
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
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
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
            text: label.endsWith('*')
                ? label.substring(0, label.length - 1)
                : label,
            style: const TextStyle(
              fontSize: 17,
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
                  'Additional Information',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,),
                _buildTextField(
                  label: 'Father Name *',
                  controller: fatherController,
                  hintText: 'Dara Phan'
                ),
                _buildTextField(
                    label: 'Father Contact Number (Optional) *',
                    controller: fatherNumberController,
                    hintText: '0983728749',
                  keyboardType: TextInputType.phone,
                ),
                _buildTextField(
                    label: 'Mother Name *',
                    controller: motherController,
                    hintText: 'Sokchea Kim'
                ),
                _buildTextField(
                    label: 'Mother Contact Number (Optional) *',
                    controller: motherNumberController,
                    hintText: '0963762849',
                  keyboardType: TextInputType.phone,
                ),
                _buildTextField(
                    label: 'Name of Your High School *',
                    controller: nameOfHighSchoolController,
                    hintText: 'Bak Touk High School'
                ),
                _buildFormField(
                  'StudyProgram *',
                  Consumer<StudyProgramAlasViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: 'it-expert',
                      options: viewModel.studyProgramNames,
                      selectedValue: _selectedStudyProgramAlas,
                      onSelected: (value) => setState(() => _selectedStudyProgramAlas = value),
                    ),
                  ),
                ),
                _buildFormField(
                  'Current address *',
                  Consumer<PlaceOfBirthViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: 'Phnom Penh',
                      options: viewModel.placeOfBirthList,
                      selectedValue: _selectedCurrentAddress,
                      onSelected: (value) => setState(() => _selectedCurrentAddress = value),
                    ),
                  ),
                ),
                _buildDropdownField(
                  label: 'Grade (Optional) *',
                  value: _selectedGrade,
                  items: gradeOptions,
                  isFormSubmitted: _isFormSubmitted,
                  hintText: 'Grade A',
                  onChanged: (value) {
                    setState(() {
                      _selectedGrade = value;
                    });
                  },
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
                          "Previous",
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
                          'Next',
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


  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    bool isLoading = false,
    String? hintText,
    required bool isFormSubmitted,
  }) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label with asterisk for required fields
          RichText(
            text: TextSpan(
              text: label.endsWith('*')
                  ? label.substring(0, label.length - 1)
                  : label,
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

          // Custom-styled dropdown
          SizedBox(
            width: double.infinity,
            child: DropdownMenu<String>(
              width: double.infinity,
              menuHeight: 250,
              hintText: hintText ?? 'Select an option',
              textStyle: const TextStyle(fontSize: 16, color: Colors.black),
              dropdownMenuEntries: items.map((item) {
                return DropdownMenuEntry(
                  value: item,
                  label: item,
                );
              }).toList(),
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
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
              errorText: isFormSubmitted && value == null
                  ? 'Please select an option'
                  : null,
              menuStyle: MenuStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              onSelected: onChanged,
            ),
          ),
        ],
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
              text: label.endsWith('*')
                  ? label.substring(0, label.length - 1)
                  : label,
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
