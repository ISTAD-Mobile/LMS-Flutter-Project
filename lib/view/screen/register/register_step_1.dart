import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/screen/register/register_step_2.dart';
import 'package:lms_mobile/viewModel/admission/degree_viewmodel.dart';
import 'package:lms_mobile/viewModel/admission/shift_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../viewModel/enroll/place_of_birth_view_model.dart';

class RegisterStep1 extends StatefulWidget {
  const RegisterStep1({super.key});
  @override
  _StudentAdmissionFormState createState() => _StudentAdmissionFormState();
}

class _StudentAdmissionFormState extends State<RegisterStep1> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedGender;
  String? _selectedShift;
  String? _selectedSpaceOfBirth;
  String? _selectedDegree;

  String? nameKh;
  String? nameEn;
  String? phone;
  String? email;
  String? guardianContact;
  String? classStudent;

  bool _isFormSubmitted = false;
  String result = '';
  bool isLoading = false;
  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = false;

  final List<String> genderOptions = ['Female', 'Male', 'Other'];
  final nameKhController = TextEditingController();
  final nameEnController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailController = TextEditingController();
  final guardianContactController = TextEditingController();
  final classStudentController = TextEditingController();

  static const int _minAge = 16;
  static const int _maxAge = 100;
  DateTime? _selectedBirthDate;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    Future.microtask(() {
      context.read<PlaceOfBirthViewModel>().fetchPlaceOfBlogs();
      context.read<ShiftViewModel>().fetchAllShifts();
      context.read<DegreeViewModel>().fetchAllDegrees();
    });
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedGender = prefs.getString('gender');
      _selectedShift = prefs.getString('shiftAlias');
      _selectedDegree = prefs.getString('degreeAlias');
      _selectedSpaceOfBirth = prefs.getString('birthPlace');
      String? birthDateString = prefs.getString('dob');
      _selectedBirthDate =
      birthDateString != null ? DateTime.tryParse(birthDateString) : null;

      nameKhController.text = prefs.getString('nameKh') ?? '';
      nameEnController.text = prefs.getString('nameEn') ?? '';
      contactNumberController.text = prefs.getString('phoneNumber') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      guardianContactController.text = prefs.getString('guardianContact') ?? '';
      classStudentController.text = prefs.getString('classStudent') ?? '';
    });
  }

  Future<void> _saveStep1DataAdmission() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('dob', _selectedBirthDate?.toIso8601String() ?? '');
    prefs.setString('gender', _selectedGender ?? '');
    prefs.setString('shiftAlias', _selectedShift ?? '');
    prefs.setString('degreeAlias', _selectedDegree ?? '');
    prefs.setString('birthPlace', _selectedSpaceOfBirth ?? '');

    prefs.setString('nameKh', nameKhController.text);
    prefs.setString('nameEn', nameEnController.text);
    prefs.setString('phoneNumber', contactNumberController.text);
    prefs.setString('email', emailController.text);
    prefs.setString('classStudent', classStudentController.text);
    prefs.setString('guardianContact', guardianContactController.text);
  }

  @override
  void dispose() {
    nameEnController.dispose();
    nameKhController.dispose();
    contactNumberController.dispose();
    emailController.dispose();
    guardianContactController.dispose();
    classStudentController.dispose();

    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isExpanded = _focusNode.hasFocus;
    });
  }


  bool _validateForm() {
    return
      _selectedGender != null &&
          _selectedDegree != null &&
          _selectedShift != null &&
          _selectedSpaceOfBirth != null &&
          _selectedBirthDate != null &&

          nameKhController.text.isNotEmpty &&
          nameEnController.text.isNotEmpty &&
          contactNumberController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          guardianContactController.text.isNotEmpty &&
          classStudentController.text.isNotEmpty &&
          contactNumberController.text.isNotEmpty;
  }


  void _showDatePicker() {
    final now = DateTime.now();
    final minDate = DateTime(now.year - _maxAge);
    final maxDate = DateTime(now.year - _minAge);

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back_ios, color: AppColors.defaultGrayColor),
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
                Text(
                  'Personal Information',
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
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
                      return 'This field is required';
                    }

                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Email *',
                  controller: emailController,
                  hintText: 'leangnaikim168@gmail.com',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildFormField(
                  label: 'Date of Birth *',
                  child: GestureDetector(
                    onTap: _showDatePicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedBirthDate != null
                                ? '${_selectedBirthDate!
                                .year}-${_selectedBirthDate!.month.toString()
                                .padLeft(2, '0')}-${_selectedBirthDate!.day
                                .toString().padLeft(2, '0')}'
                                : 'Select Date of Birth',
                            style: const TextStyle(fontSize: 16 ),
                          ),
                          const Icon(CupertinoIcons.calendar,
                              color: Colors.grey),
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
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    String phonePattern = r'^[0-9]{9,15}$';
                    RegExp regex = RegExp(phonePattern);

                    if (!regex.hasMatch(value)) {
                      return 'This field is required';
                    }

                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Guardian Contact *',
                  controller: guardianContactController,
                  keyboardType: TextInputType.phone,
                  hintText: '092382489',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    String phonePattern = r'^[0-9]{9,15}$';
                    RegExp regex = RegExp(phonePattern);

                    if (!regex.hasMatch(value)) {
                      return 'This field is required';
                    }

                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Class Student *',
                  controller: classStudentController,
                  hintText: 'class student',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    return null;
                  },
                ),
                _buildFormFieldAddress(
                  'Shift *',
                  Consumer<ShiftViewModel>(
                    builder: (context, viewModel, _) =>
                        _buildDropdownMenu(
                          hint: 'weekday-morning',
                          options: viewModel.shiftNames,
                          selectedValue: _selectedShift,
                          onSelected: (value) =>
                              setState(() =>
                              _selectedShift = value),
                        ),
                  ),
                ),
                _buildFormFieldAddress(
                  'Degree *',
                  Consumer<DegreeViewModel>(
                    builder: (context, viewModel, _) =>
                        _buildDropdownMenu(
                          hint: 'master',
                          options: viewModel.degreeNames,
                          selectedValue: _selectedDegree,
                          onSelected: (value) =>
                              setState(() => _selectedDegree = value),
                        ),
                  ),
                ),
                  _buildDropdownField(
                    label: 'Gender *',
                    value: _selectedGender,
                    items: genderOptions,
                    hintText: 'Female',
                    isLoading: false,
                    isFormSubmitted: _isFormSubmitted,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                  ),
                _buildFormFieldAddress(
                  'Place of birth *',
                  Consumer<PlaceOfBirthViewModel>(
                    builder: (context, viewModel, _) =>
                        _buildDropdownMenu(
                          hint: 'Phnom Penh',
                          options: viewModel.placeOfBirthList,
                          selectedValue: _selectedSpaceOfBirth,
                          onSelected: (value) =>
                              setState(() => _selectedSpaceOfBirth = value),
                        ),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() => _isFormSubmitted = true);
                        if (_formKey.currentState!.validate() &&
                            _validateForm()) {
                          await _saveStep1DataAdmission();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterStep2()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please complete the form')),
                          );
                        }
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 16, color: AppColors
                            .defaultWhiteColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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

  Widget _buildFormFieldAddress(String label, Widget child) {
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

  Widget _buildFormField({
    required String label,
    required Widget child,
  }) {
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
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey,
                  fontWeight: FontWeight.w200,
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
                borderSide: const BorderSide(
                    color: AppColors.primaryColor, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 16),
            ),
          ),
        ],
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
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
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
