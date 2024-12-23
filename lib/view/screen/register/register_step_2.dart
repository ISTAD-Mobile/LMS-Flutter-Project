// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lms_mobile/data/color/color_screen.dart';
// import 'package:lms_mobile/view/screen/register/register_step_3.dart';
//
// class RegisterStep2 extends StatefulWidget {
//   const RegisterStep2({Key? key}) : super(key: key);
//   @override
//   _StudentAdmissionFormState createState() => _StudentAdmissionFormState();
// }
//
// class _StudentAdmissionFormState extends State<RegisterStep2> {
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedProvince;
//   String? _selectedCurrentAddress;
//   String? _selectedGrade;
//
//   File? _selectedImage;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickImage() async {
//     final XFile? pickedImage = await _picker.pickImage(
//         source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
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
//           style: TextStyle(
//             color: AppColors.primaryColor,
//             fontSize: 16,
//           ),
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
//                   'Education Information',
//                   style: TextStyle(
//                     color: AppColors.primaryColor,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 _buildDropdownField(
//                   label: 'Class Student *',
//                   value: _selectedProvince,
//                   hintText: 'Science Class',
//                   items: [
//                     'Science Class',
//                     'Social Science Class',
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedProvince = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty ||
//                         value == 'Select Class') {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildDropdownField(
//                   label: 'Grade (Optional) *',
//                   value: _selectedGrade,
//                   hintText: 'Select a Grade',
//                   items: [
//                     'Select a Grade',
//                     'Grade A',
//                     'Grade B',
//                     'Grade C',
//                     'Grade D',
//                     'Grade E',
//                     'Grade F',
//                     'Grade Auto',
//                     'Waiting for Results',
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedGrade = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty ||
//                         value == 'Select a Grade') {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildDropdownField(
//                   label: 'Diploma Session *',
//                   value: _selectedCurrentAddress,
//                   hintText: 'Select a Diploma Session',
//                   items: [
//                     'Select a Diploma Session',
//                     '2021',
//                     '2022',
//                     '2023',
//                     '2024',
//                     'Other',
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedCurrentAddress = value;
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
//                 Text(
//                   'High Certificate (Optional)',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 SizedBox(height: 8,),
//                 GestureDetector(
//                   onTap: _pickImage,
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
//                     child: _selectedImage == null
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
//                           "Please provide a BacII certificate (Cambodia National Exam Certificate), exam result or equivalent professional degree",
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
//                         _selectedImage!,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16,),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: SizedBox(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.grey.shade100,
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 25),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               side: BorderSide(
//                                   color: Colors.grey.shade300, width: 1),
//                             ),
//                           ),
//                           child: const Text(
//                             "Previous",
//                             style: TextStyle(color: AppColors.defaultGrayColor),
//                           ),
//                         ),
//                         SizedBox(width: 20,),
//                         ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text('Processing Data')),
//                               );
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => RegisterStep3(),
//                                 ),
//                               );
//                             }
//                           },
//                           child: const Text(
//                             'Next',
//                             style: TextStyle(fontSize: 16,
//                                 color: AppColors.defaultWhiteColor),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primaryColor,
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 25),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               // side: BorderSide(color: Colors.grey.shade300, width: 1),
//                             ),
//                           ),
//                         ),
//                       ],
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
//               text: label.endsWith('*')
//                   ? label.substring(0, label.length - 1)
//                   : label,
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
//                 borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 12, vertical: 16),
//             ),
//             hint: hintText != null ? Text(hintText, style: const TextStyle(
//                 color: Colors.grey, fontWeight: FontWeight.w400),) : null,
//           ),
//         ],
//       ),
//     );
//   }
// }






import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/resource/app_url.dart';
import 'package:lms_mobile/view/screen/register/register_step_3.dart';
import 'package:http/http.dart' as http;

class RegisterStep2 extends StatefulWidget {
  const RegisterStep2({Key? key}) : super(key: key);

  @override
  _StudentAdmissionFormState createState() => _StudentAdmissionFormState();
}

class _StudentAdmissionFormState extends State<RegisterStep2> {
  final _formKey = GlobalKey<FormState>();
  String? selectedClassStudent;
  String? selectedGrade;
  String? selectedDiplomaSession;
  String result = '';
  bool isLoading = false;

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
                  'Education Information',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildDropdownField(
                  label: 'Class Student *',
                  value: selectedClassStudent,
                  hintText: 'Science Class',
                  items: [
                    'Science Class',
                    'Social Science Class',
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedClassStudent = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 'Select Class') {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildDropdownField(
                  label: 'Grade (Optional) *',
                  value: selectedGrade,
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
                    'Waiting for Results',
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGrade = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 'Select a Grade') {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                _buildDropdownField(
                  label: 'Diploma Session *',
                  value: selectedDiplomaSession,
                  hintText: 'Select a Diploma Session',
                  items: [
                    'Select a Diploma Session',
                    '2021',
                    '2022',
                    '2023',
                    '2024',
                    'Other',
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedDiplomaSession = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 'Select a province') {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                Text(
                  'High Certificate (Optional)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _showImageSourceOptions(context),
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
                    child: _selectedHighCertificate == null
                        ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_download_outlined,
                            color: AppColors.primaryColor, size: 40),
                        SizedBox(height: 5),
                        Text(
                          'Select a file or drag and drop here',
                          style: TextStyle(color: AppColors.defaultBlackColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Please provide a BacII certificate (Cambodia National Exam Certificate), exam result or equivalent professional degree",
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
                        _selectedHighCertificate!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
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
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            try {
                              await _stepTwoFormSubmit();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterStep3(),
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

  void _showImageSourceOptions(BuildContext context) async {
    final pickedSource = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Camera'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                title: Text('Gallery'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (pickedSource != null) {
      _pickImageHighCertificate(pickedSource);
    }
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
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            hint: hintText != null ? Text(hintText, style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400),) : null,
          ),
        ],
      ),
    );
  }
}
