// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:lms_mobile/data/color/color_screen.dart';
// import 'package:lms_mobile/data/network/api_service.dart';
// import 'package:lms_mobile/view/screen/register/register_step_2.dart';
// import 'package:lms_mobile/viewModel/admission_viewmodel.dart';
//
//
// class RegisterStep1 extends StatefulWidget {
//   const RegisterStep1({Key? key}) : super(key: key);
//
//   @override
//   _StudentAdmissionFormState createState() => _StudentAdmissionFormState();
// }
//
// class _StudentAdmissionFormState extends State<RegisterStep1> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameKhController = TextEditingController();
//   final TextEditingController _nameEnController = TextEditingController();
//   final TextEditingController _dateOfBirthController = TextEditingController();
//   final TextEditingController _contactNumberController = TextEditingController();
//   final TextEditingController _contactEmailController = TextEditingController();
//   final TextEditingController _contactHighSchoolController = TextEditingController();
//   final TextEditingController _contactContactNumberController = TextEditingController();
//   final TextEditingController _contactGuardianContactController = TextEditingController();
//
//
//   String? _selectedGender;
//   String? _selectedPlaceOfBirth;
//   String? _selectCurrentAddress;
//   String? _selectGuardianRelationship;
//   String? _selectGetToKnowIstad;
//
//   @override
//   void dispose() {
//     _nameKhController.dispose();
//     _nameEnController.dispose();
//     _dateOfBirthController.dispose();
//     _contactNumberController.dispose();
//     _contactEmailController.dispose();
//     _contactHighSchoolController.dispose();
//     _contactContactNumberController.dispose();
//     _contactGuardianContactController.dispose();
//     super.dispose();
//   }
//
//
//   File? _selectedUploadIdentity;
//   final ImagePicker _pickerUploadIdentity = ImagePicker();
//
//   Future<void> _pickImageUploadIndentity() async {
//     final XFile? pickedUploadIndentiry = await _pickerUploadIdentity.pickImage(source: ImageSource.gallery);
//     if (pickedUploadIndentiry != null) {
//       setState(() {
//         _selectedUploadIdentity = File(pickedUploadIndentiry.path);
//       });
//     }
//   }
//
//   File? _selectedHighCertificate;
//   final ImagePicker _pickerCertificate = ImagePicker();
//
//   Future<void> _pickImageCertificate() async {
//     final XFile? pickedImageCertificate = await _pickerCertificate.pickImage(source: ImageSource.gallery);
//     if (pickedImageCertificate != null) {
//       setState(() {
//         _selectedHighCertificate = File(pickedImageCertificate.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: AppColors.defaultGrayColor),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           'Student Admission',
//           style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Personal Information',
//                   style: TextStyle(
//                     color: Colors.indigo[900],
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildTextField(
//                   label: 'Name (KH) *',
//                   controller: _nameKhController,
//                   hintText: 'លាង ណៃគីម',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your name in Khmer';
//                     }
//
//                     final khmerRegex = RegExp(r'^[\u1780-\u17FF\s]+$');
//                     if (!khmerRegex.hasMatch(value)) {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildTextField(
//                   label: 'Name (EN) *',
//                   controller: _nameEnController,
//                   hintText: 'Leang Naikim',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildDropdownField(
//                   label: 'Gender *',
//                   value: _selectedGender,
//                   hintText: 'Female',
//                   items: ['Female', 'Male', 'Other'],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedGender = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildDateField(
//                   label: 'Date of Birth *',
//                   controller: _dateOfBirthController,
//                   hintText: '30/08/2003',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildTextField(
//                   label: 'Contact Number (Telegram) *',
//                   controller: _contactNumberController,
//                   keyboardType: TextInputType.phone,
//                   hintText: '092382489',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildTextField(
//                   label: 'Email *',
//                   controller: _contactEmailController,
//                   // keyboardType: TextInputType.phone,
//                   hintText: 'student.istad@gmail.com',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildTextField(
//                   label: 'High School *',
//                   controller: _contactHighSchoolController,
//                   hintText: 'Bak Touk High School',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildDropdownField(
//                   label: 'Place of Birth *',
//                   value: _selectedPlaceOfBirth,
//                   hintText: 'Phnom Penh',
//                   items: [
//                     'Select a province',
//                     'Phnom Penh',
//                     'Siem Reap',
//                     'Battambang',
//                     'Kampot',
//                     'Kandal',
//                     'Kep',
//                     'Koh Kong',
//                     'Banteay Meanchey',
//                     'Kampong Cham',
//                     'Kampong Speu',
//                     'Kampong Thom',
//                     'Kratie',
//                     'Mondulkiri',
//                     'Oddar Meanchey',
//                     'Peilin',
//                     'Preah Sihanouk',
//                     'Preah Vihear',
//                     'Prey Veng',
//                     'Pursat',
//                     'Rotanakiri',
//                     'Stung Treng',
//                     'Svay Rieng',
//                     'Takeo',
//                     'Tboung Khmum',
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedPlaceOfBirth = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty ||
//                         value == 'Select a province') {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildDropdownField(
//                   label: 'Current Address *',
//                   value: _selectCurrentAddress,
//                   hintText: 'Phnom Penh',
//                   items: [
//                     'Select a province',
//                     'Phnom Penh',
//                     'Siem Reap',
//                     'Battambang',
//                     'Kampot',
//                     'Kandal',
//                     'Kep',
//                     'Koh Kong',
//                     'Banteay Meanchey',
//                     'Kampong Cham',
//                     'Kampong Speu',
//                     'Kampong Thom',
//                     'Kratie',
//                     'Mondulkiri',
//                     'Oddar Meanchey',
//                     'Peilin',
//                     'Preah Sihanouk',
//                     'Preah Vihear',
//                     'Prey Veng',
//                     'Pursat',
//                     'Rotanakiri',
//                     'Stung Treng',
//                     'Svay Rieng',
//                     'Takeo',
//                     'Tboung Khmum',
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectCurrentAddress = value!;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty ||
//                         value == 'Select a province') {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildTextField(
//                   label: 'Guardian Contact *',
//                   controller: _contactGuardianContactController,
//                   keyboardType: TextInputType.phone,
//                   hintText: '092382489',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildDropdownField(
//                   label: 'Guardian Relationship *',
//                   value: _selectGuardianRelationship,
//                   hintText: 'Select a province',
//                   items: [
//                     'Select a province',
//                     'Mother',
//                     'Father',
//                     'Grandmother',
//                     'Grandfather',
//                     'Aunt',
//                     'Uncle',
//                     'Elder Sister',
//                     'Elder Brother',
//                     'Legal Guardian',
//                     'Cousin',
//                     'Sibling',
//                     'Other',
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectGuardianRelationship = value!;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty ||
//                         value == 'Select a province') {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildDropdownField(
//                   label: 'Get to know ISTAD through: *',
//                   value: _selectGetToKnowIstad,
//                   hintText: 'Select how you knew about ISTAD',
//                   items: [
//                     'Select how you knew about ISTAD',
//                     'Ministry, Provincial Department',
//                     'Teacher',
//                     'Senior Student',
//                     'Social Media (Facebook)',
//                     'Friend',
//                     'Website',
//                     'Parents or Relative',
//                     'Other',
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectGetToKnowIstad = value!;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty ||
//                         value == 'Select a province') {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         const Text(
//                           "Sample Photo",
//                           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                         ),
//                         const SizedBox(height: 10),
//                         Container(
//                           width: 135,
//                           height: 160,
//                           decoration: BoxDecoration(
//                             // border: Border.all(color: Colors.grey),
//                             color: Colors.grey.shade200,
//                           ),
//                           child: Image.asset(
//                             'assets/images/cher_muyleang.png',
//                             fit: BoxFit.cover,
//                             // color: AppColors.defaultGrayColor,
//                             width: 20,
//                             height: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Upload Formal Picture',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 SizedBox(height: 8,),
//                 GestureDetector(
//                   onTap: _pickImageCertificate,
//                   child: Container(
//                     width: double.infinity,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey.shade400,
//                         width: 1.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: _selectedHighCertificate == null
//                         ? const Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.cloud_download_outlined,
//                             color: AppColors.primaryColor, size: 40),
//                         SizedBox(height: 5),
//                         Text(
//                           'Avatar',
//                           style: TextStyle(color: AppColors.defaultBlackColor),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           "Select a file or drag and drop here",
//                           style: TextStyle(
//                             color: AppColors.defaultBlackColor,
//                             fontSize: 13,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           "JPG,PNG or PDF,file size no more than 10MB",
//                           style: TextStyle(color: Colors.grey, fontSize: 12),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     )
//                         : ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.file(
//                         _selectedHighCertificate!,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16,),
//                 Text(
//                   'Upload Identity (Optional)',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 SizedBox(height: 8,),
//                 GestureDetector(
//                   onTap: _pickImageUploadIndentity,
//                   child: Container(
//                     width: double.infinity,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey.shade400,
//                         width: 1.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: _selectedUploadIdentity == null
//                         ? const Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.cloud_download_outlined,
//                             color: AppColors.primaryColor, size: 40),
//                         SizedBox(height: 5),
//                         Text(
//                           'Select a file or drag and drop here',
//                           style: TextStyle(color: AppColors.defaultBlackColor),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           "JPG,PNG or PDF,file size no more than 10MB",
//                           style: TextStyle(color: Colors.grey, fontSize: 12),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     )
//                         : ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.file(
//                         _selectedUploadIdentity!,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: SizedBox(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Processing Data')),
//                           );
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const RegisterStep2(),
//                             ),
//                           );
//                         }
//                       },
//                       child: const Text(
//                         'Next',
//                         style: TextStyle(fontSize: 16, color: AppColors.defaultWhiteColor),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           // side: BorderSide(color: Colors.grey.shade300, width: 1),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     String? hintText,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           RichText(
//             text: TextSpan(
//               text: label.endsWith('*') ? label.substring(0, label.length - 1) : label,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: AppColors.primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//               children: [
//                 if (label.endsWith('*'))
//                   const TextSpan(
//                     text: ' *',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//           TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             validator: validator,
//             cursorColor: AppColors.primaryColor,
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400,fontFamily: 'NotoSansKhmer'),
//               filled: true,
//               fillColor: Colors.transparent,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: Colors.grey.shade400,
//                   // width: 2,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: Colors.grey.shade400,
//                   // width: 2,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(color: AppColors.primaryColor,width: 2),
//               ),
//               contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildDropdownField({
//     required String label,
//     required String? value,
//     required List<String> items,
//     String? hintText,
//     required void Function(String?) onChanged,
//     String? Function(String?)? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           RichText(
//             text: TextSpan(
//               text: label.endsWith('*') ? label.substring(0, label.length - 1) : label,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: AppColors.primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//               children: [
//                 if (label.endsWith('*'))
//                   const TextSpan(
//                     text: ' *',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//           DropdownButtonFormField<String>(
//             value: value,
//             items: items.map((String item) {
//               return DropdownMenuItem(
//                 value: item,
//                 child: Text(item),
//               );
//             }).toList(),
//             onChanged: onChanged,
//             validator: validator,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.transparent,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: Colors.grey.shade400,
//                   // width: 2,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: Colors.grey.shade400,
//                   // width: 2,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: AppColors.primaryColor,width: 2),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 12, vertical: 16),
//             ),
//             hint: hintText != null ? Text(hintText, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),) : null,
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildDateField({
//     required String label,
//     required TextEditingController controller,
//     String? hintText,
//     String? Function(String?)? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           RichText(
//             text: TextSpan(
//               text: label.endsWith('*') ? label.substring(0, label.length - 1) : label,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: AppColors.primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//               children: [
//                 if (label.endsWith('*'))
//                   const TextSpan(
//                     text: ' *',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//           TextFormField(
//             controller: controller,
//             readOnly: true,
//             onTap: () async {
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(1900),
//                 lastDate: DateTime.now(),
//               );
//               if (pickedDate != null) {
//                 String formattedDate = DateFormat('dd-MM-yyyy').format(
//                     pickedDate);
//                 setState(() {
//                   controller.text = formattedDate;
//                 });
//               }
//             },
//             validator: validator,
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: const TextStyle(
//                   color: Colors.grey, fontWeight: FontWeight.w400
//               ),
//               // Add hintText here
//               filled: true,
//               fillColor: Colors.transparent,
//               suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: Colors.grey.shade400,
//                   // width: 2,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: Colors.grey.shade400,
//                   // width: 2,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: AppColors.primaryColor,width: 2),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 12, vertical: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//





// Future<void> _submitForm() async {
//   if (_formKey.currentState!.validate()) {
//     var uri = Uri.parse(AdmissionUrl.getadmisionByUrl);
//     var request = http.MultipartRequest('POST', uri);
//
//     request.fields['name_kh'] = _nameKhController.text;
//     request.fields['name_en'] = _nameEnController.text;
//     request.fields['date_of_birth'] = _dateOfBirthController.text;
//     request.fields['contact_number'] = _contactNumberController.text;
//     request.fields['email'] = _contactEmailController.text;
//     request.fields['high_school'] = _contactHighSchoolController.text;
//     request.fields['place_of_birth'] = _selectedPlaceOfBirth ?? '';
//     request.fields['current_address'] = _selectCurrentAddress ?? '';
//     request.fields['guardian_contact'] = _contactGuardianContactController.text;
//     request.fields['guardian_relationship'] = _selectGuardianRelationship ?? '';
//     request.fields['get_to_know_istad'] = _selectGetToKnowIstad ?? '';
//     request.fields['gender'] = _selectedGender ?? '';
//
//     if (_selectedHighCertificate != null) {
//       request.files.add(await http.MultipartFile.fromPath(
//           'high_certificate',
//           _selectedHighCertificate!.path
//       ));
//     }
//
//     if (_selectedUploadIdentity != null) {
//       request.files.add(await http.MultipartFile.fromPath(
//           'upload_identity',
//           _selectedUploadIdentity!.path
//       ));
//     }
//
//     try {
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         // Handle success
//         print('Registration successful!');
//       } else {
//         // Handle failure
//         print('Failed to register');
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//     }
//   }
// }





import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/resource/app_url.dart';
import 'package:lms_mobile/view/screen/register/register_step_2.dart';
import 'package:http/http.dart' as http;
import 'package:lms_mobile/view/screen/register/register_step_3.dart';
import 'package:lms_mobile/viewModel/admission_viewmodel.dart';

class RegisterStep1 extends StatefulWidget {
  const RegisterStep1({Key? key}) : super(key: key);
  @override
  _StudentAdmissionFormState createState() => _StudentAdmissionFormState();
}

class _StudentAdmissionFormState extends State<RegisterStep1> {

  final _admissionViewModel = AdmissionViewmodel();

  final _formKey = GlobalKey<FormState>();
  final nameKhController = TextEditingController();
  final nameEnController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final contactNumberController = TextEditingController();
  final contactEmailController = TextEditingController();
  final contactHighSchoolController = TextEditingController();
  final contactContactNumberController = TextEditingController();
  final contactGuardianContactController = TextEditingController();

  String result = '';
  bool isLoading = false;

  String? selectedGender;
  String? selectedPlaceOfBirth;
  String? selectCurrentAddress;
  String? selectGuardianRelationship;
  String? selectGetToKnowIstad;

  File? _selectedUploadFormal;
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

  // Future<void> _stepOneFormSubmit() async {
  //   var admissionRequest = Admissio(
  //
  //   );
  //   _admissionViewModel.postAdmission(data);
  //
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.defaultGrayColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
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
                    // Check if the value is empty
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    // Check if the value contains only alphabetic characters (no numbers or special chars)
                    String pattern = r'^[a-zA-Z\s]+$'; // Allows alphabetic characters and spaces
                    RegExp regex = RegExp(pattern);

                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid name (letters and spaces only)';
                    }

                    return null;
                  },
                ),

                _buildDropdownField(
                  label: 'Gender *',
                  value: selectedGender,
                  hintText: 'Female',
                  items: ['Female', 'Male', 'Other'],
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildDateField(
                  label: 'Date of Birth *',
                  controller: dateOfBirthController,
                  hintText: '30/08/2003',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
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
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

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
                SizedBox(height: 20),
                Text(
                  'Upload Formal Picture',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _pickImageUploadFormal(ImageSource.gallery),
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
                    child: _selectedUploadFormal == null
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
                          'Avatar',
                          style: TextStyle(color: AppColors.defaultBlackColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Select a file or drag and drop here",
                          style: TextStyle(
                            color: AppColors.defaultBlackColor,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
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
                        _selectedUploadFormal!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                const Text(
                  'Upload Identity (Optional)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _pickUploadIdentity(ImageSource.gallery),
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
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    child: ElevatedButton(
                      // onPressed: _stepOneFormSubmit,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          try {
                            // await _stepTwoFormSubmit();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterStep2(),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error processing data')),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 16, color: AppColors.defaultWhiteColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                  // width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                  // width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primaryColor,width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
          DropdownButtonFormField<String>(
            value: value,
            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                  // width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                  // width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primaryColor,width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 16),
            ),
            hint: hintText != null ? Text(hintText, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),) : null,
          ),
        ],
      ),
    );
  }


  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    String? hintText,
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
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                String formattedDate = DateFormat('dd-MM-yyyy').format(
                    pickedDate);
                setState(() {
                  controller.text = formattedDate;
                });
              }
            },
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w400
              ),
              // Add hintText here
              filled: true,
              fillColor: Colors.transparent,
              suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                  // width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                  // width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primaryColor,width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}







