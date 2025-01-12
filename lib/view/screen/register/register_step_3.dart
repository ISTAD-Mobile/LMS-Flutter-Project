import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/model/admission/admission_form.dart';
import 'package:lms_mobile/viewModel/admission/admission_viewmodel.dart';
import 'package:lms_mobile/viewModel/admission/upload_image_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/network/upload_image.dart';
import '../../../data/response/status.dart';


class RegisterStep3 extends StatefulWidget {

  @override
  _StudentAdmissionScreenState createState() => _StudentAdmissionScreenState();
}

class _StudentAdmissionScreenState extends State<RegisterStep3> {
  final _formKey = GlobalKey<FormState>();

  final getToKnowIstadController = TextEditingController();
  final guardianRelationShipController = TextEditingController();
  final diplomaSessionController = TextEditingController();
  var imageFile;
  final admissionViewModel = AdmissionViewmodel();

  String? getToKnowIstad;
  String? whoGuideYou;
  String? diplomaSession;

  Future<void> _saveStep3DataAdmission() async {
    var admissionRequest = AdmissionRequest(
      knownIstad: getToKnowIstadController.text,
      guardianRelationShip: guardianRelationShipController.text,
      vocationTrainingIiiCertificate: imageFile.toString(),
    );
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('getToKnowIstad', getToKnowIstad ?? '');
    prefs.setString('whoGuideYou', whoGuideYou ?? '');
    prefs.setString('Relationship', diplomaSession ?? '');

    admissionViewModel.postAdmission(admissionRequest);
  }

  bool _validateForm() {
    return getToKnowIstadController.text.isNotEmpty &&
        guardianRelationShipController.text.isNotEmpty &&
        diplomaSessionController.text.isNotEmpty ;
  }

  bool _isFormSubmitted = false;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        isLoading = true;
      });

      Uint8List bytes = await image.readAsBytes();

      setState(() {
        _imageBytes = bytes;
        isLoading = false;
      });

      // Upload the image
      UploadApiImage().uploadImage(bytes, image.name).then((value) {
        if (value != null && value.containsKey('uri')) {
          print("Updated Successfully with link ${value['uri']}");
        } else {
          print('Image upload failed: No URI found');
        }
      }).onError((error, stackTrace) {
        setState(() {
          isLoading = false;
        });
        print('Error: ${error.toString()}');
      });
    }
  }



  String isImageUploade = "";
  bool isLoading = false;

  Uint8List? _imageBytes;

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
                _buildTextField(
                  label: 'Get to know ISTAD through: *',
                  controller: getToKnowIstadController,
                  hintText: 'Please specify how you knew about ISTAD',
                ),
                _buildTextField(
                  label: 'GuardianRelationShip *',
                  controller: guardianRelationShipController,
                  hintText: 'Teacher or Friend ...etc',
                ),
                _buildTextField(
                  label: 'DiplomaSession *',
                  controller: diplomaSessionController,
                  hintText: 'Uncle or Friends ...etc',
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
                const SizedBox(height: 25,),
                ChangeNotifierProvider(
                  create: (_) => ImageViewModel(),
                  child: Consumer<ImageViewModel>(
                    builder: (context, viewModel, _) {
                      final imageResponse = viewModel.response;

                      if (imageResponse.status == Status.LOADING) {
                        // Show loading indicator
                        return const Center(child: CircularProgressIndicator());
                      } else if (imageResponse.status == Status.ERROR) {
                        // Show error message
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline, color: Colors.red, size: 50),
                              const SizedBox(height: 10),
                              Text(
                                "Error: ${imageResponse.message ?? 'Something went wrong'}",
                                style: const TextStyle(color: Colors.red),
                              ),
                              ElevatedButton(
                                onPressed: _pickImage,
                                child: const Text("Retry"),
                              ),
                            ],
                          ),
                        );
                      } else if (imageResponse.status == Status.COMPLETED) {
                        return Center(
                          child: Container(
                            height: 230,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: MemoryImage(_imageBytes!), // Assuming _imageBytes is set after upload
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      } else {
                        // Default UI when no image is selected
                        return Center(
                          child: InkWell(
                            onTap: _pickImage,
                            child: Container(
                              height: 230,
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 50,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Avatar",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Please upload a photo where your face is visible",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "JPG, PNG or PDF, file size no more than 10MB",
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Row(
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
                          await _saveStep3DataAdmission();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Form submitted successfully')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please complete the form')),
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
                        'Submit',
                        style: TextStyle(fontSize: 16, color: AppColors.defaultWhiteColor),
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
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,),
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
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
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
}



