import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/screen/register/register_step_1.dart';
import 'package:lms_mobile/view/screen/register/register_step_3.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/appbar_register.dart';

class RegisterStep2 extends StatefulWidget {
  const RegisterStep2({Key? key}) : super(key: key);

  @override
  _StudentAdmissionFormState createState() => _StudentAdmissionFormState();
}

class _StudentAdmissionFormState extends State<RegisterStep2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherContactController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _motherContactController = TextEditingController();
  final TextEditingController _nameOfHightSchoolController = TextEditingController();
  final TextEditingController _getToKnowIstadController = TextEditingController();
  final TextEditingController _whoGuideYouController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  String? _selectedProvince;
  String? _selectedCurrentAddress;
  String? _selectedGrade;

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
                Text(
                  'Additional Information',
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Father Name *',
                  controller: _fatherNameController,
                  hintText: 'Dara Phan',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name in Khmer';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Father Contact Number (Optional) *',
                  controller: _fatherContactController,
                  hintText: '0965432135',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name in Khmer';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Mother Name *',
                  controller: _motherNameController,
                  hintText: 'Sokchea Kim',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name in English';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Mother Contact Number (Optional) *',
                  controller: _motherContactController,
                  hintText: '0965495043',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name in English';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Name of Your High School *',
                  controller: _nameOfHightSchoolController,
                  hintText: 'Bak Touk High School',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name in English';
                    }
                    return null;
                  },
                ),
                _buildDropdownField(
                  label: 'Province *',
                  value: _selectedProvince,
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
                      _selectedProvince = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty ||
                        value == 'Select a province') {
                      return 'Please select your place of birth';
                    }
                    return null;
                  },
                ),
                _buildDropdownField(
                  label: 'Grade (Optional) *',
                  value: _selectedGrade,
                  hintText: 'Select a Grade',
                  items: [
                    'Select a Grade',
                    'Grade A',
                    'Grade B',
                    'Grade C',
                    'Grade D',
                    'Grade E',
                    'Grade F',
                    'Grade Auto',
                    'Grade Not Yet Released',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedGrade = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty ||
                        value == 'Select a province') {
                      return 'Please select your place of birth';
                    }
                    return null;
                  },
                ),
                _buildDropdownField(
                  label: 'Current Address *',
                  value: _selectedCurrentAddress,
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
                      _selectedCurrentAddress = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty ||
                        value == 'Select a province') {
                      return 'Please select your place of birth';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Get to know ISTAD through: *',
                  controller: _getToKnowIstadController,
                  hintText: 'Please specify how you knew about ISTAD',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Who guide you to enroll (Optional) *',
                  controller: _whoGuideYouController,
                  hintText: 'Teacher or Friend',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: 'Relationship (Optional) *',
                  controller: _relationshipController,
                  hintText: 'Uncle or Friends',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterStep1()),
                            );
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
                        SizedBox(width: 20,),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterStep3(),
                                ),
                              );
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
                              // side: BorderSide(color: Colors.grey.shade300, width: 1),
                            ),
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
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                  // width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                  // width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
              filled: true,
              fillColor: Colors.transparent,
              suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.defaultBlackColor!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.defaultGrayColor!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primaryColor!),
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