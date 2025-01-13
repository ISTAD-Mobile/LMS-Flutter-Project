import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/viewModel/enroll/current_address_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/university_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/place_of_birth_view_model.dart';
import '../../../../viewModel/enroll/enrollment_view_model.dart';
import '../../../screen/enrollments/enrollment_provider.dart';
import 'enroll_step1.dart';
import 'enroll_step3.dart';

class EnrollStep2 extends StatefulWidget {
  // final EnrollmentFormData formData;

  const EnrollStep2({super.key, required EnrollmentFormData formData,});

  @override
  State<EnrollStep2> createState() => _CourseEnrollForm();
}

class _CourseEnrollForm extends State<EnrollStep2> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final currentAddressController = TextEditingController();
  final educationController = TextEditingController();
  final universitiesController = TextEditingController();
  final _enrollmentViewModel = EnrollmentViewModel();
  bool _isFormSubmitted = false;

  DateTime? _selectedBirthDate;
  String? _selectedBirthAddress;
  String? _selectedCurrentAddress;
  String? _selectedEducation;
  String? _selectedUniversity;

  static const int _minAge = 16;
  static const int _maxAge = 100;
  static const List<String> educationOptions = [
    'Association',
    'Bachelor',
    'Master',
    'PhD',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData().then((_) {
      dateOfBirthController.text = _selectedBirthDate?.toIso8601String() ?? '';
      placeOfBirthController.text = _selectedBirthAddress ?? '';
      currentAddressController.text = _selectedCurrentAddress ?? '';
      educationController.text = _selectedEducation ?? '';
      universitiesController.text = _selectedUniversity ?? '';
    });
    Future.microtask(() {
      context.read<PlaceOfBirthViewModel>().fetchPlaceOfBlogs();
      context.read<CurrentAddressViewModel>().fetchCurrentAddressBlogs();
      context.read<UniversityViewModel>().fetchUniversityBlogs();
    });
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedBirthDate = DateTime.tryParse(prefs.getString('birthDate') ?? '') ?? _selectedBirthDate;
      _selectedBirthAddress = prefs.getString('birthAddress') ?? _selectedBirthAddress;
      _selectedCurrentAddress = prefs.getString('currentAddress') ?? _selectedCurrentAddress;
      _selectedEducation = prefs.getString('education') ?? _selectedEducation;
      _selectedUniversity = prefs.getString('university') ?? _selectedUniversity;
    });
  }

  Future<void> _saveStep2Data() async {
    final prefs = await SharedPreferences.getInstance();
    if (_selectedBirthDate != null) {
      prefs.setString('birthDate', _selectedBirthDate!.toIso8601String());
    }
    if (_selectedBirthAddress != null) {
      prefs.setString('birthAddress', _selectedBirthAddress!);
    }
    if (_selectedCurrentAddress != null) {
      prefs.setString('currentAddress', _selectedCurrentAddress!);
    }
    if (_selectedEducation != null) {
      prefs.setString('education', _selectedEducation!);
    }
    if (_selectedUniversity != null) {
      prefs.setString('university', _selectedUniversity!);
    }
  }

  void _onNextPressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Save only if there are changes
      if (_isDataChanged()) {
        await _saveStep2Data();
      }

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EnrollStep3(formData: EnrollmentFormData(), uuid: ''),
          ),
        );
      }
    } else {
      setState(() => _isFormSubmitted = true);
    }
  }

  bool _isDataChanged() {
    return _selectedBirthDate != null ||
        _selectedBirthAddress != null ||
        _selectedCurrentAddress != null ||
        _selectedEducation != null ||
        _selectedUniversity != null;
  }



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
        ),
        dropdownMenuEntries: options.map((e) =>
            DropdownMenuEntry(value: e, label: e)
        ).toList(),
        onSelected: onSelected,
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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EnrollStep1(formData: EnrollmentFormData(),
                ),
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
                _buildFormField(
                  controller: dateOfBirthController,
                  label: 'Date of Birth',
                  child: GestureDetector(
                    onTap: _showDatePicker,
                    child: _buildDateField(),
                  ),
                ),
                _buildFormField(
                  controller: placeOfBirthController,
                  label: 'Place of birth',
                  child: Consumer<PlaceOfBirthViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: 'Select place of birth',
                      options: viewModel.placeOfBirthList,
                      selectedValue: _selectedBirthAddress,
                      onSelected: (value) => setState(() => _selectedBirthAddress = value),
                    ),
                  ),
                ),
                _buildFormField(
                  controller: currentAddressController,
                  label: 'Current address',
                  child: Consumer<CurrentAddressViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: 'Select current address',
                      options: viewModel.currentAddressList,
                      selectedValue: _selectedCurrentAddress,
                      onSelected: (value) => setState(() => _selectedCurrentAddress = value),
                    ),
                  ),
                ),
                _buildFormField(
                  controller: educationController,
                  label: 'Education',
                  child: _buildDropdownMenu(
                    hint: 'Select education',
                    options: educationOptions,
                    selectedValue: _selectedEducation,
                    onSelected: (value) => setState(() => _selectedEducation = value),
                  ),
                ),
                _buildFormField(
                  controller: universitiesController,
                  label: 'University',
                  child: Consumer<UniversityViewModel>(
                    builder: (context, viewModel, _) => _buildDropdownMenu(
                      hint: 'Select University',
                      options: viewModel.universityList,
                      selectedValue: _selectedUniversity,
                      onSelected: (value) => setState(() => _selectedUniversity = value),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
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
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
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

  Widget _buildNavigationButtons() {
    final enrollmentState = Provider.of<EnrollmentStateNotifier>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () async {
            await enrollmentState.updateStep2(
              birthDate: _selectedBirthDate,
              birthAddress: _selectedBirthAddress,
              currentAddress: _selectedCurrentAddress,
              education: _selectedEducation,
              university: _selectedUniversity,
            );

            // Save to SharedPreferences
            await _saveStep2Data();

            if (mounted) {
                // Navigate to the screen detail
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => EnrollStep1(formData: EnrollmentFormData()),
                  ),
                );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text(
            'Previous',
            style: TextStyle(color: AppColors.defaultGrayColor, fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              // Save current form data before proceeding
              await enrollmentState.updateStep2(
                birthDate: _selectedBirthDate,
                birthAddress: _selectedBirthAddress,
                currentAddress: _selectedCurrentAddress,
                education: _selectedEducation,
                university: _selectedUniversity,
              );

              await _saveStep2Data();

              if (mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnrollStep3(formData: EnrollmentFormData(), uuid: '',
                    ),
                  ),
                );
              }
            } else {
              setState(() => _isFormSubmitted = true);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text(
            'Next',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  // Widget _buildNavigationButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       ElevatedButton(
  //         onPressed: () => Navigator.pop(context),
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.grey[300],
  //           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         ),
  //         child: const Text(
  //           'Previous',
  //           style: TextStyle(color: AppColors.defaultGrayColor, fontSize: 16),
  //         ),
  //       ),
  //       ElevatedButton(
  //         onPressed: () {
  //           if (_formKey.currentState?.validate() ?? false) {
  //             _saveStep2Data();
  //             Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => EnrollStep3(formData: EnrollmentFormData(), uuid: '',)),
  //             );
  //           } else {
  //             setState(() => _isFormSubmitted = true);
  //           }
  //         },
  //         style: ElevatedButton.styleFrom(
  //           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
  //           backgroundColor: AppColors.primaryColor,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         ),
  //         child: const Text(
  //           'Next',
  //           style: TextStyle(color: Colors.white, fontSize: 16),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:lms_mobile/data/color/color_screen.dart';
// import 'package:lms_mobile/viewModel/enroll/current_address_view_model.dart';
// import 'package:lms_mobile/viewModel/enroll/university_view_model.dart';
// import 'package:lms_mobile/viewModel/enroll/place_of_birth_view_model.dart';
// import '../../../../viewModel/enroll/enrollment_view_model.dart';
// import '../../../screen/enrollments/enrollment_provider.dart';
// import 'enroll_step1.dart';
// import 'enroll_step3.dart';
//
// class EnrollStep2 extends StatefulWidget {
//   final EnrollmentFormData formData;
//
//   const EnrollStep2({Key? key, required this.formData}) : super(key: key);
//
//   @override
//   State<EnrollStep2> createState() => _EnrollStep2State();
// }
//
// class _EnrollStep2State extends State<EnrollStep2> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isFormSubmitted = false;
//
//   DateTime? _selectedBirthDate;
//   String? _selectedBirthAddress;
//   String? _selectedCurrentAddress;
//   String? _selectedEducation;
//   String? _selectedUniversity;
//
//   static const List<String> educationOptions = [
//     'Association',
//     'Bachelor',
//     'Master',
//     'PhD',
//     'Other',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedData();
//     _fetchInitialData();
//   }
//
//   Future<void> _loadSavedData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _selectedBirthDate = DateTime.tryParse(prefs.getString('birthDate') ?? '');
//       _selectedBirthAddress = prefs.getString('birthAddress');
//       _selectedCurrentAddress = prefs.getString('currentAddress');
//       _selectedEducation = prefs.getString('education');
//       _selectedUniversity = prefs.getString('university');
//     });
//   }
//
//   Future<void> _saveStep2Data() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('birthDate', _selectedBirthDate?.toIso8601String() ?? '');
//     await prefs.setString('birthAddress', _selectedBirthAddress ?? '');
//     await prefs.setString('currentAddress', _selectedCurrentAddress ?? '');
//     await prefs.setString('education', _selectedEducation ?? '');
//     await prefs.setString('university', _selectedUniversity ?? '');
//   }
//
//   void _fetchInitialData() {
//     Future.microtask(() {
//       context.read<PlaceOfBirthViewModel>().fetchPlaceOfBlogs();
//       context.read<CurrentAddressViewModel>().fetchCurrentAddressBlogs();
//       context.read<UniversityViewModel>().fetchUniversityBlogs();
//     });
//   }
//
//   void _showDatePicker() {
//     final now = DateTime.now();
//     final maxDate = DateTime(now.year - 16);
//     final minDate = DateTime(now.year - 100);
//
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => Container(
//         height: 216,
//         padding: const EdgeInsets.only(top: 6.0),
//         color: CupertinoColors.systemBackground.resolveFrom(context),
//         child: SafeArea(
//           top: false,
//           child: CupertinoDatePicker(
//             mode: CupertinoDatePickerMode.date,
//             initialDateTime: _selectedBirthDate ?? maxDate,
//             minimumDate: minDate,
//             maximumDate: maxDate,
//             onDateTimeChanged: (DateTime newDate) {
//               setState(() => _selectedBirthDate = newDate);
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDropdownMenu({
//     required String hint,
//     required List<String> options,
//     required String? selectedValue,
//     required void Function(String?) onSelected,
//   }) {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         hintText: hint,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//       value: selectedValue,
//       items: options
//           .map((option) => DropdownMenuItem(
//         value: option,
//         child: Text(option),
//       ))
//           .toList(),
//       onChanged: onSelected,
//       validator: (value) => value == null ? 'Please select $hint' : null,
//     );
//   }
//
//   Widget _buildFormField({
//     required String label,
//     required Widget child,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           child,
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavigationButtons() {
//     final enrollmentState = Provider.of<EnrollmentStateNotifier>(context, listen: false);
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         ElevatedButton(
//           onPressed: () async {
//             await enrollmentState.updateStep2(
//               birthDate: _selectedBirthDate,
//               birthAddress: _selectedBirthAddress,
//               currentAddress: _selectedCurrentAddress,
//               education: _selectedEducation,
//               university: _selectedUniversity,
//             );
//
//             // Save to SharedPreferences
//             await _saveStep2Data();
//
//             if (mounted) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => EnrollStep1(formData: EnrollmentFormData()),
//                 ),
//               );
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.grey[300],
//             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//           child: const Text(
//             'Previous',
//             style: TextStyle(color: AppColors.defaultGrayColor, fontSize: 16),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             if (_formKey.currentState?.validate() ?? false) {
//               // Save current form data before proceeding
//               await enrollmentState.updateStep2(
//                 birthDate: _selectedBirthDate,
//                 birthAddress: _selectedBirthAddress,
//                 currentAddress: _selectedCurrentAddress,
//                 education: _selectedEducation,
//                 university: _selectedUniversity,
//               );
//
//               await _saveStep2Data();
//
//               if (mounted) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => EnrollStep3(
//                       formData: EnrollmentFormData(),
//                       uuid: '',
//                     ),
//                   ),
//                 );
//               }
//             } else {
//               setState(() => _isFormSubmitted = true);
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//             backgroundColor: AppColors.primaryColor,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//           child: const Text(
//             'Next',
//             style: TextStyle(color: Colors.white, fontSize: 16),
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Enrollment Step 2')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildFormField(
//                 label: 'Date of Birth',
//                 child: GestureDetector(
//                   onTap: _showDatePicker,
//                   child: InputDecorator(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Select Date of Birth',
//                     ),
//                     child: Text(
//                       _selectedBirthDate != null
//                           ? '${_selectedBirthDate!.year}-${_selectedBirthDate!.month.toString().padLeft(2, '0')}-${_selectedBirthDate!.day.toString().padLeft(2, '0')}'
//                           : 'Select Date of Birth',
//                     ),
//                   ),
//                 ),
//               ),
//               _buildFormField(
//                 label: 'Place of Birth',
//                 child: Consumer<PlaceOfBirthViewModel>(
//                   builder: (context, viewModel, _) => _buildDropdownMenu(
//                     hint: 'Place of Birth',
//                     options: viewModel.placeOfBirthList,
//                     selectedValue: _selectedBirthAddress,
//                     onSelected: (value) => setState(() => _selectedBirthAddress = value),
//                   ),
//                 ),
//               ),
//               _buildFormField(
//                 label: 'Current Address',
//                 child: Consumer<CurrentAddressViewModel>(
//                   builder: (context, viewModel, _) => _buildDropdownMenu(
//                     hint: 'Current Address',
//                     options: viewModel.currentAddressList,
//                     selectedValue: _selectedCurrentAddress,
//                     onSelected: (value) => setState(() => _selectedCurrentAddress = value),
//                   ),
//                 ),
//               ),
//               _buildFormField(
//                 label: 'Education',
//                 child: _buildDropdownMenu(
//                   hint: 'Education',
//                   options: educationOptions,
//                   selectedValue: _selectedEducation,
//                   onSelected: (value) => setState(() => _selectedEducation = value),
//                 ),
//               ),
//               _buildFormField(
//                 label: 'University',
//                 child: Consumer<UniversityViewModel>(
//                   builder: (context, viewModel, _) => _buildDropdownMenu(
//                     hint: 'University',
//                     options: viewModel.universityList,
//                     selectedValue: _selectedUniversity,
//                     onSelected: (value) => setState(() => _selectedUniversity = value),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               _buildNavigationButtons(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

