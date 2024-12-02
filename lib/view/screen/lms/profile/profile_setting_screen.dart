import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../data/color/color_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _StudentSettingsState createState() => _StudentSettingsState();
}

class _StudentSettingsState extends State<SettingScreen> {

  File? _image;
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _khmerNameController = TextEditingController(text: "ញឹម ទេវី");
  final _englishNameController = TextEditingController(text: "Nhoem Tevy");
  final _addressController = TextEditingController(text: "Kandel");
  final _personalNumberController = TextEditingController(text: "+855483058935");
  final _familyNumberController = TextEditingController(text: "+855883058935");

  final khmerNameFocus = FocusNode();
  final englishNameFocus = FocusNode();
  final addressFocus = FocusNode();
  final personalNumberFocus = FocusNode();
  final familyNumberFocus = FocusNode();


  @override
  void dispose() {
    khmerNameFocus.dispose();
    englishNameFocus.dispose();
    addressFocus.dispose();
    personalNumberFocus.dispose();
    familyNumberFocus.dispose();
    super.dispose();
  }


  String _gender = "Female";
  DateTime _dateOfBirth = DateTime(2003, 8, 30);

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'STUDENT SETTING',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 20),
                // Profile Image
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : const AssetImage('assets/images/tevy.png') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1A237E),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Form Fields
                _buildTextField(
                  label: 'Full Name (KH)',
                  controller: _khmerNameController,
                  focusNode: khmerNameFocus,
                ),
                _buildTextField(
                  label: 'Full Name (EN)',
                  controller: _englishNameController,
                  focusNode: englishNameFocus,
                ),
                _buildDropdownField(
                  label: 'Gender',
                  value: _gender,
                  items: ['Male', 'Female', 'Other'],
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                _buildDateField(
                  label: 'Date Of Birth',
                  value: _dateOfBirth,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _dateOfBirth,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _dateOfBirth = picked;
                      });
                    }
                  },
                ),
                _buildTextField(
                  label: 'Current Address',
                  controller: _addressController,
                  focusNode: addressFocus,
                ),
                _buildTextField(
                  label: 'Personal Number',
                  controller: _personalNumberController,
                  keyboardType: TextInputType.phone,
                  focusNode: personalNumberFocus,
                ),
                _buildTextField(
                  label: 'Family Number',
                  controller: _familyNumberController,
                  keyboardType: TextInputType.phone,
                  focusNode: familyNumberFocus,
                ),

                // Buttons
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: AppColors.primaryColor),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle save logic here
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: const Text('Save',style: TextStyle(color: AppColors.defaultWhiteColor),),
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    FocusNode? focusNode,
  }) {
    // final localFocusNode = focusNode ?? FocusNode();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        focusNode: focusNode ?? FocusNode(),
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          floatingLabelStyle: TextStyle(
            color: focusNode?.hasFocus == true ? AppColors.primaryColor : AppColors.defaultGrayColor,
          ),
        ),
          onTap: () {
              setState(() {});
            },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    final FocusNode focusNode = FocusNode();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
        ),
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime value,
    required VoidCallback onTap,
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: AbsorbPointer(
          child: TextFormField(
            focusNode: focusNode ?? FocusNode(),
            decoration: InputDecoration(
              labelText: label,
              border: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              floatingLabelStyle: TextStyle(
                color: focusNode?.hasFocus == true ? AppColors.primaryColor : AppColors.defaultGrayColor,
              ),
            ),
            controller: TextEditingController(
              text: "${value.day}/${value.month}/${value.year}",
            ),
          ),
        ),
      ),
    );
  }
}