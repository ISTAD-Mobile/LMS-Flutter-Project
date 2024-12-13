import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_mobile/view/screen/register/register_step_2.dart';

import '../../../data/color/color_screen.dart';

void main() => runApp(StudentAdmissionApp());

class StudentAdmissionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterStep3(),
    );
  }
}

class RegisterStep3 extends StatefulWidget {
  @override
  _StudentAdmissionScreenState createState() => _StudentAdmissionScreenState();
}

class _StudentAdmissionScreenState extends State<RegisterStep3> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _submit() {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload a formal picture before submitting.")),
      );
    } else {
      // Handle image submission logic
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Submitted Successfully"),
          content: Text("Image path: ${_selectedImage!.path}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.defaultGrayColor),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        title: Text(
          'Student Admission',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload Formal Picture (បើមាន)",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Upload Image Box
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _selectedImage == null
                        ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_download_outlined, color: AppColors.primaryColor, size: 40),
                        SizedBox(height: 5),
                        Text('Avatar',style: TextStyle(color: AppColors.defaultBlackColor),),
                        SizedBox(height: 10),
                        Text(
                          "Please upload a photo",
                          style: TextStyle(color: AppColors.defaultBlackColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Sample Photo
                Column(
                  children: [
                    const Text(
                      "Sample Photo",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 110,
                      height: 135,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey),
                        color: Colors.grey.shade200,
                      ),
                      child: Image.asset(
                        'assets/images/sample_image.png',
                        fit: BoxFit.contain,
                        color: AppColors.defaultGrayColor,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterStep2()),
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
                const SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Submit", style: TextStyle(color: AppColors.defaultWhiteColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
