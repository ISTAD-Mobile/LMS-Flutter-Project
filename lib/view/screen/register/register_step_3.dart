import 'dart:typed_data';
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
import '../../widgets/sytem_screen/successfully_admission.dart';

class RegisterStep3 extends StatefulWidget {
  @override
  _StudentAdmissionScreenState createState() => _StudentAdmissionScreenState();
}

class _StudentAdmissionScreenState extends State<RegisterStep3> {
  final _formKey = GlobalKey<FormState>();

  final getToKnowIstadController = TextEditingController();
  final guardianRelationShipController = TextEditingController();
  var imageFile;

  final admissionViewModel = AdmissionViewmodel();
  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      getToKnowIstadController.text = prefs.getString('knownIstad') ?? '';
      guardianRelationShipController.text = prefs.getString('guardianRelationShip') ?? '';
    });
  }

  Future<Map<String, dynamic>?> _saveStep3DataAdmission() async {
    final prefs = await SharedPreferences.getInstance();
    String certificate = (imageFile != null && imageFile.isNotEmpty) ? imageFile : "94cad2f2-0519-468d-840c-248393478b00.jpg";


    var admissionRequest = AdmissionRequest(
      knownIstad: getToKnowIstadController.text,
      guardianRelationShip: guardianRelationShipController.text,
      // vocationTrainingIiiCertificate: certificate,
      // diplomaSession: diplomaSessionController.text,
      gender: prefs.getString('gender') ?? 'Unknown',
      shiftAlias: prefs.getString('shiftAlias') ?? 'Unknown',
      // degreeAlias: prefs.getString('degreeAlias') ?? 'Unknown',
      email: prefs.getString('email') ?? 'Unknown',
      nameEn: prefs.getString('nameEn') ?? 'Unknown',
      nameKh: prefs.getString('nameKh') ?? 'Unknown',
      dob: prefs.getString('dob') != null
          ? DateTime.tryParse(prefs.getString('dob')!)
          : null,
      birthPlace: prefs.getString('birthPlace') ?? 'Unknown',
      // studyProgramAlias: prefs.getString('studyProgramAlias') ?? 'Unknown',
      motherName: prefs.getString('motherName') ?? 'Unknown',
      motherPhoneNumber: prefs.getString('motherPhoneNumber') ?? 'Unknown',
      fatherName: prefs.getString('fatherName') ?? 'Unknown',
      fatherPhoneNumber: prefs.getString('fatherPhoneNumber') ?? 'Unknown',
      address: prefs.getString('address') ?? 'Unknown',
      bacIiGrade: prefs.getString('bacIiGrade') ?? 'Unknown',
      phoneNumber: prefs.getString('phoneNumber') ?? 'Unknown',
      highSchool: prefs.getString('highSchool') ?? 'Unknown',
    );

    print('Full admission request: ${admissionRequest.toJson()}');

    final response = await admissionViewModel.postAdmission(admissionRequest);
    print('Received response: $response');

    if (response != null) {
      final telegramLink = response['telegramLink'];
      final studentName = response['studentName'];

      // Clear preferences only on successful submission
      await prefs.clear();

      return {
        'telegramLink': telegramLink,
        'studentName': studentName,
      };
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Submission failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }

  bool _isFormSubmitted = false;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      isLoading = true;
    });

    if (image != null) {
      // Image was selected, proceed with upload
      Uint8List bytes = await image.readAsBytes();

      setState(() {
        _imageBytes = bytes;
        isLoading = false;
      });

      // Upload image
      UploadApiImage().uploadImage(bytes, image.name).then((value) {
        if (value != null && value.containsKey('name')) {
          String uploadedImageUri = value['name'];
          print("Image uploaded successfully: $uploadedImageUri");

          setState(() {
            imageFile = uploadedImageUri; // Save the uploaded image URI
          });
        } else {
          print('Image upload failed: No URI found');
        }
      }).onError((error, stackTrace) {
        setState(() {
          isLoading = false;
        });
        print('Error: ${error.toString()}');
      });
    } else {
      // No image selected, set to placeholder image
      print('No image selected, using placeholder');

      setState(() {
        imageFile = "94cad2f2-0519-468d-840c-248393478b00.jpg";
      });
    }
  }

  bool _isSubmitting = false;
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
                _buildTextField(
                  label: 'ស្គាល់ ISTAD តាមរយៈ ',
                  controller: getToKnowIstadController,
                  hintText: 'សូមបញ្ជាក់ពីរបៀបដែលអ្នកបានដឹងអំពី ISTAD',
                ),
                _buildTextField(
                  label: 'អ្នកណែនាំឲ្យចុះឈ្មោះរៀន (បើមាន) ',
                  controller: guardianRelationShipController,
                  hintText: 'គ្រូ ឬ មិត្ត ...ផ្សេងៗ',
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "គំរូរូបភាព",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight
                              .w500),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 135,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          child: Image.asset(
                            'assets/images/cher_muyleang.png',
                            fit: BoxFit.cover,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ChangeNotifierProvider(
                          create: (_) => ImageViewModel(),
                          child: Consumer<ImageViewModel>(
                            builder: (context, viewModel, _) {
                              final imageResponse = viewModel.response;

                              if (imageResponse.status == Status.LOADING) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (imageResponse.status == Status.ERROR) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.error_outline,
                                          color: Colors.red, size: 50),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Error: ${imageResponse.message ??
                                            'Something went wrong'}",
                                        style: const TextStyle(
                                            color: Colors.red),
                                      ),
                                      ElevatedButton(
                                        onPressed: _pickImage,
                                        child: const Text("Retry"),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Center(
                                  child: InkWell(
                                    onTap: _pickImage,
                                    child: Container(
                                      height: 200,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(12),
                                        image: _imageBytes != null
                                            ? DecorationImage(
                                          image: MemoryImage(_imageBytes!),
                                          fit: BoxFit.cover,
                                        )
                                            : null,
                                      ),
                                      child: _imageBytes == null
                                          ? const Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Icon(
                                            Icons.cloud_upload_outlined,
                                            size: 50,
                                            color: AppColors.primaryColor,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "រូបថត",
                                            style: TextStyle(fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 5),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              "ប្រភេទឯកសារ JPG, PNG or PDF, ទំហំឯកសារមិនលើសពី 10MB",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      )
                                          : null,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.grey.shade300,
                              width: 1),
                        ),
                      ),
                      child: const Text(
                        "ថយក្រោយ",
                        style: TextStyle(color: AppColors.defaultGrayColor),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() => _isFormSubmitted = true);

                        // Skip validation and proceed with the form submission directly
                        setState(() {
                          _isSubmitting = true;
                        });

                        try {
                          // Print all form data for debugging
                          print('Form Data:');
                          print('Known ISTAD: ${getToKnowIstadController.text.trim()}');
                          print('Guardian Relationship: ${guardianRelationShipController.text.trim()}');
                          print('Image File: $imageFile');

                          final response = await _saveStep3DataAdmission();
                          setState(() {
                            _isSubmitting = false;
                          });

                          if (response != null) {
                            final telegramLink = response['telegramLink'] ?? 'Default Telegram Link';
                            final studentName = response['studentName'] ?? 'Unknown Student';

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccessfullyAdmissionPage(
                                  telegramLink: telegramLink,
                                  studentName: studentName,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Submission failed. Please try again.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } catch (e) {
                          setState(() {
                            _isSubmitting = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('An error occurred: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: AppColors.primaryColor, width: 1),
                        ),
                      ),
                      child: const Text(
                        'ចុះឈ្មោះ',
                        style: TextStyle(color: AppColors.defaultWhiteColor),
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
              text: label.endsWith('')
                  ? label.substring(0, label.length - 1)
                  : label,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              children: [
                if (label.endsWith(''))
                  const TextSpan(
                    text: ' ',
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
            validator: (value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return 'ត្រូវការបំពេញ';
              }
              return null;
            },
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
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
                horizontal: 12,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}