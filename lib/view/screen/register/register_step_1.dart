import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/screen/register/register_step_2.dart';
import 'package:lms_mobile/viewModel/admission/degree_viewmodel.dart';
import 'package:lms_mobile/viewModel/admission/shift_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../viewModel/admission/study_program_alas.dart';
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
  String? _selectedPlaceOfBirth;
  String? _selectedDegree;
  String? _studyProgramAlias;
  String? _selectedGrade;

  String? nameKh;
  String? nameEn;
  String? phone;
  String? email;
  String? dob;
  String? guardianContact = '';
  String? classStudent = '';
  final List<String> gradeOptions = ['និទ្ទេស A','និទ្ទេស B','និទ្ទេស C', 'និទ្ទេស D', 'និទ្ទេស E', 'ជាប់អូតូ','ផ្សេងៗ'];

  bool _isFormSubmitted = false;
  String result = '';
  bool isLoading = false;
  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = false;

  final List<String> genderOptions = ['ស្រី', 'ប្រុស', 'ផ្សេងៗ'];
  final nameKhController = TextEditingController();
  final nameEnController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailController = TextEditingController();
  final guardianContactController = TextEditingController();
  final classStudentController = TextEditingController(text: "class student");

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
      context.read<StudyProgramAlasViewModel>().fetchAllStudyPrograms();
    });
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      String? birthDateString = prefs.getString('dob');
      _selectedBirthDate =
      birthDateString != null ? DateTime.tryParse(birthDateString) : null;
      _studyProgramAlias = prefs.getString('studyProgram');
      _selectedGender = prefs.getString('gender');
      _selectedShift = prefs.getString('shiftAlias');
      _selectedDegree = prefs.getString('degreeAlias');
      _selectedPlaceOfBirth = prefs.getString('birthPlace');
      _selectedGrade = prefs.getString('bacIiGrade');

      nameKhController.text = prefs.getString('nameKh') ?? '';
      nameEnController.text = prefs.getString('nameEn') ?? '';
      contactNumberController.text = prefs.getString('phoneNumber') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      guardianContactController.text = prefs.getString('guardianContact') ?? '';
      classStudentController.text = prefs.getString('classStudent') ?? 'class student';
    });
  }

  Future<void> _saveStep1DataAdmission() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('dob', _selectedBirthDate?.toIso8601String() ?? '');
    prefs.setString('gender', _selectedGender ?? '');
    prefs.setString('shiftAlias', _selectedShift ?? '');
    prefs.setString('degreeAlias', _selectedDegree ?? '');
    prefs.setString('birthPlace', _selectedPlaceOfBirth ?? '');
    prefs.setString('studyProgramAlias', _studyProgramAlias ?? '');
    prefs.setString('bacIiGrade', _selectedGrade ?? '');

    prefs.setString('nameKh', nameKhController.text);
    prefs.setString('nameEn', nameEnController.text);
    prefs.setString('phoneNumber', contactNumberController.text);
    prefs.setString('email', emailController.text);
    prefs.setString('classStudent', classStudentController.text.isNotEmpty
        ? classStudentController.text
        : 'class student');
    prefs.setString('guardianContact', guardianContactController.text);
    prefs.setString('bacIiGrade', _selectedGrade ?? '');

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
          _selectedPlaceOfBirth != null &&
          _selectedBirthDate != null &&
          _selectedGrade != null &&

          nameKhController.text.isNotEmpty &&
          nameEnController.text.isNotEmpty &&
          contactNumberController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          guardianContactController.text.isNotEmpty &&
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
                const Text(
                  'ព័ត៌មានផ្ទាល់ខ្លួន',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansKhmer',
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'គោត្តនាម និងនាម (ជាភាសាខ្មែរ) *',
                  controller: nameKhController,
                  hintText: 'លាង ណៃគីម',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ត្រូវការបំពេញគោត្តនាម និងនាមជាភាសាខ្មែរ';
                    }

                    final khmerRegex = RegExp(r'^[\u1780-\u17FF\s]+$');
                    if (!khmerRegex.hasMatch(value)) {
                      return 'ត្រូវការបំពេញ';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'គោត្តនាម និងនាម (ភាសាអង់គ្លេស) *',
                  controller: nameEnController,
                  hintText: 'Leang Naikim',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ត្រូវការបំពេញគោត្តនាម និងនាមជាភាសាអង់គ្លេស';
                    }
                    String pattern = r'^[a-zA-Z\s]+$';
                    RegExp regex = RegExp(pattern);

                    if (!regex.hasMatch(value)) {
                      return 'ត្រូវការបំពេញ';
                    }

                    return null;
                  },
                ),
                _buildDropdownField(
                  label: 'ភេទ *',
                  value: _selectedGender,
                  items: genderOptions,
                  hintText: _selectedGender?.isNotEmpty == true
                      ? _selectedGender!
                      : 'ភេទ',
                  isLoading: false,
                  isFormSubmitted: _isFormSubmitted,
                  onSelected: (value) async {
                    setState(() {
                      _selectedGender = value;
                    });

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('gender', value ?? '');
                  },
                ),
                _buildTextField(
                  label: 'អុីមែល *',
                  controller: emailController,
                  hintText: 'leangnaikim168@gmail.com',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ត្រូវការបំពេញ';
                    }
                    return null;
                  },
                ),
                _buildFormField(
                  label: 'ថ្ងៃខែឆ្នាំកំណើត *',
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
                                : 'ជ្រើសរើសថ្ងៃខែឆ្នាំកំណើត',
                            style: const TextStyle(fontSize: 16 ),
                          ),
                          const Icon(CupertinoIcons.calendar,
                              color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildFormFieldAddress(
                  'ទីកន្លែងកំណើត  *',
                  Consumer<PlaceOfBirthViewModel>(
                    builder: (context, viewModel, _) =>
                        _buildDropdownMenu(
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
                            await prefs.setString('Date of Birth', value ?? '');
                          },
                        ),
                  ),
                ),
                _buildTextField(
                  label: 'លេខទូរស័ព្ទ ទំនាក់ទំនង (Telegram) *',
                  controller: contactNumberController,
                  keyboardType: TextInputType.phone,
                  hintText: '092382489',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ត្រូវការបំពេញ';
                    }

                    String phonePattern = r'^[0-9]{9,15}$';
                    RegExp regex = RegExp(phonePattern);

                    if (!regex.hasMatch(value)) {
                      return 'ត្រូវការបំពេញ';
                    }

                    return null;
                  },
                ),
                _buildTextField(
                  label: 'លេខទូរស័ព្ទ ទំនាក់ទំនង (Telegram) *',
                  controller: guardianContactController,
                  keyboardType: TextInputType.phone,
                  hintText: '0923824897',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ត្រូវការបំពេញ';
                    }

                    String phonePattern = r'^[0-9]{9,15}$';
                    RegExp regex = RegExp(phonePattern);

                    if (!regex.hasMatch(value)) {
                      return 'ត្រូវការបំពេញ';
                    }

                    return null;
                  },
                ),
                _buildFormFieldAddress(
                  'កម្មវិធីសិក្សា *',
                  Consumer<StudyProgramAlasViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: _studyProgramAlias?.isNotEmpty == true
                          ? _studyProgramAlias!
                          : 'ជ្រើសរើសកម្មវិធីសិក្សា',
                      options: viewModel.studyProgramNames,
                      selectedValue: _studyProgramAlias,
                      onSelected: (value) async {
                        setState(() {
                          _studyProgramAlias = value;
                        });

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('studyProgram', value ?? '');
                        print("Saved StudyProgram: $value");
                      },
                    ),
                  ),
                ),
                _buildFormFieldAddress(
                  'វេនសិក្សា *',
                  Consumer<ShiftViewModel>(
                    builder: (context, viewModel, _) =>
                        _buildDropdownMenu(
                          hint: _selectedShift?.isNotEmpty == true
                              ? _selectedShift!
                              : 'ជ្រើសរើសវេនសិក្សា',
                          options: viewModel.shiftNames,
                          selectedValue: _selectedShift,
                          onSelected: (value) async {
                            setState(() {
                              _selectedShift = value;
                            });

                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('Shift', value ?? '');
                          },
                        ),
                  ),
                ),
                _buildFormFieldAddress(
                  'កម្រិតសញ្ញាបត្រ *',
                  Consumer<DegreeViewModel>(
                    builder: (context, viewModel, _) =>
                        _buildDropdownMenu(
                          hint: _selectedDegree?.isNotEmpty == true
                              ? _selectedDegree!
                              : 'ជ្រើសរើសកម្រិតសញ្ញាបត្រ',
                          options: viewModel.degreeNames,
                          selectedValue: _selectedDegree,
                          onSelected: (value) async {
                            setState(() {
                              _selectedDegree = value;
                            });

                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('Degree', value ?? '');
                          },
                        ),
                  ),
                ),
                _buildDropdownField(
                  label: 'ទទួលបាននិទ្ទេសរួម (បើមាន) *',
                  value: _selectedGrade,
                  items: gradeOptions,
                  isFormSubmitted: _isFormSubmitted,
                  hintText: _selectedGrade?.isNotEmpty == true
                      ? _selectedGrade!
                      : 'ជ្រើសរើសនិទ្ទេស',
                  onSelected: (String? newValue) async {
                    setState(() {
                      _selectedGrade = newValue;
                    });

                    // Save to SharedPreferences
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('grade', newValue ?? '');
                    print("Saved Grade: $newValue");
                  },
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
                        'បន្ទាប់',
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
        const SizedBox(height: 2),
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
        const SizedBox(height: 2),
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
          const SizedBox(height: 2),
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
    required void Function(String?) onSelected,
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
          const SizedBox(height: 2),
          // Custom-styled dropdown
          SizedBox(
            width: double.infinity,
            child: DropdownMenu<String>(
              width: double.infinity,
              menuHeight: 250,
              hintText: hintText ?? 'ជ្រើសរើសជម្រើស',
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
                  ? 'ត្រូវការបំពេញ'
                  : null,
              menuStyle: MenuStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              onSelected: onSelected,
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
      textStyle: const TextStyle(fontSize: 16, color: Colors.black), // Text color when selected
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
