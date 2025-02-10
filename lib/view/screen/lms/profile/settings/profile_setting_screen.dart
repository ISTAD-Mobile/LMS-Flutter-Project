import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_mobile/view/screen/lms/profile/settings/static_profile_setting_screen.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../../../../../data/color/color_screen.dart';
import '../../../../../data/network/upload_image.dart';
import '../../../../../model/student_profile_setting.dart';
import 'dart:async';
import '../../../../../repository/update_student_profile_setting_repository.dart';
import '../../../../../viewModel/updata_student_profile_setting_viewmodel.dart';


class SettingScreen extends StatefulWidget {

  final String token;
  const SettingScreen({required this.token, Key? key}) : super(key: key);

  @override
  _StudentSettingsState createState() => _StudentSettingsState(accessToken: token);
}

class _StudentSettingsState extends State<SettingScreen> {
  final String accessToken;
  _StudentSettingsState({required this.accessToken});

  late UpdataStudentProfileSettingViewmodel viewModel;
  late Future<StudentSettingModel> _futureAlbum;


  File? _image;
  final _formKey = GlobalKey<FormState>();

  final _bioController = TextEditingController();
  final _currentAddressController = TextEditingController();
  final _personalNumberController = TextEditingController();
  final _familyNumberController = TextEditingController();
  final _placeOfBirthController = TextEditingController();
  final _nameEnController = TextEditingController();

  final bioFocus = FocusNode();
  final currentAddressFocus = FocusNode();
  final personalNumberFocus = FocusNode();
  final familyNumberFocus = FocusNode();
  final placeOfBirthFocus = FocusNode();
  final nameEnFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    viewModel = UpdataStudentProfileSettingViewmodel(
      repository: UpdateStudentProfileSettingRepository(token: widget.token),
    );
    Future.delayed(Duration.zero, () {
      viewModel.fetchUserData();
    });

  }



  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        isLoading = true;
      });
      Uint8List bytes = await image.readAsBytes();
      UploadApiImage()
          .uploadImage(bytes, image.name)
          .then((value) {
        if (value != null && value.containsKey('uri')) {
          setState(() {
            isImageUploade = value['uri'];
            print('Image URI to be updated: $isImageUploade');
            isLoading = false;
          });
          print("Updated Successfully with link ${value['uri']}");
        } else {
          setState(() {
            isLoading = false;
          });
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

  void _initializePages() {
    setState(() {
      print("Initializing pages...");
    });
  }


  void fetchUpdatedData() {
    setState(() {
      _initializePages();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.defaultGrayColor),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
        ),
        title: const Text(
          'Student Setting',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) {
          final viewModel = UpdataStudentProfileSettingViewmodel(
              repository: UpdateStudentProfileSettingRepository(token: widget.token)
          );
          viewModel.fetchUserData();
          return viewModel;
        },
        child: Consumer<UpdataStudentProfileSettingViewmodel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/animation/loading.json',
                  width: 100,
                  height: 100,
                ),
              );
            } else if (viewModel.errorMessage.isNotEmpty) {
              return Center(child: Text(viewModel.errorMessage));
            } else if (viewModel.userData == null) {
              return const Center(child: Text('No user data available'));
            }

            final userData = viewModel.userData!;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image Section
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: isImageUploade.isNotEmpty
                                  ? NetworkImage(isImageUploade)
                                  : (userData.profileImage != null && userData.profileImage!.isNotEmpty
                                  ? NetworkImage(userData.profileImage!)
                                  : const AssetImage('assets/images/placeholder.jpg')) as ImageProvider,
                              onBackgroundImageError: (_, __) {
                                print('Failed to load image.');
                              },
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
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
                      _buildTextField(
                        value: userData.nameEn,
                        label: 'NameEn',
                        controller: _nameEnController,
                        focusNode: nameEnFocus,
                      ),
                      _buildDropdownField(
                        label: 'Gender',
                        value: userData.gender != null && ['Male', 'Female', 'Other'].contains(userData.gender)
                            ? userData.gender
                            : '',
                        items: ['Male', 'Female', 'Other'],
                        onChanged: (value) {
                          setState(() {
                            userData.gender = value ?? '';
                          });
                        },
                      ),
                      _buildTextField(
                        value: userData.birthPlace,
                        label: 'Place Of Birth',
                        controller: _placeOfBirthController,
                        focusNode: placeOfBirthFocus,
                      ),
                      _buildTextField(
                        value: userData.currentAddress,
                        label: 'Current Address',
                        controller: _currentAddressController,
                        focusNode: currentAddressFocus,
                      ),
                      _buildTextField(
                        value: userData.phoneNumber,
                        label: 'Personal Number',
                        controller: _personalNumberController,
                        keyboardType: TextInputType.phone,
                        focusNode: personalNumberFocus,
                      ),
                      _buildTextField(
                        value: userData.biography,
                        label: 'Biography',
                        controller: _bioController,
                        focusNode: bioFocus,
                      ),
                      _buildTextField(
                        value: userData.familyPhoneNumber,
                        label: 'Family Number',
                        controller: _familyNumberController,
                        keyboardType: TextInputType.phone,
                        focusNode: familyNumberFocus,
                      ),
                      _buildDropdownField(
                        label: 'Guardian Relationship',
                        value: userData.guardianRelationShip.isNotEmpty && ['Mother', 'Father', 'Sibling', 'Other'].contains(userData.guardianRelationShip)
                            ? userData.guardianRelationShip
                            : 'Other',
                        items: ['Mother', 'Father', 'Sibling', 'Other'],
                        onChanged: (value) {
                          setState(() {
                            userData.guardianRelationShip = value ?? 'Other';
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                _personalNumberController.text = userData.phoneNumber ?? '';
                                _familyNumberController.text = userData.familyPhoneNumber ?? '';
                                _bioController.text = userData.biography ?? '';
                                _currentAddressController.text = userData.currentAddress ?? '';
                                _placeOfBirthController.text = userData.birthPlace ?? '';

                                setState(() {
                                  userData.gender = userData.gender ?? '';
                                  userData.guardianRelationShip = userData.guardianRelationShip ?? '';
                                });

                                isImageUploade = '';
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
                                side: const BorderSide(color: AppColors.primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: AppColors.primaryColor, fontSize: 16.0),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final profileImage = isImageUploade.isNotEmpty ? isImageUploade : userData.profileImage ?? '';

                                  try {
                                    await viewModel.updateUserData(
                                      phoneNumber: _personalNumberController.text,
                                      familyPhoneNumber: _familyNumberController.text,
                                      guardianRelationShip: userData.guardianRelationShip.isEmpty
                                          ? 'Other'
                                          : userData.guardianRelationShip,
                                      biography: _bioController.text,
                                      currentAddress: _currentAddressController.text,
                                      birthPlace: _placeOfBirthController.text,
                                      gender: userData.gender.isEmpty ? 'Male' : userData.gender,
                                      profileImage: profileImage,
                                      nameEn: _nameEnController.text,
                                    );

                                  } catch (error) {
                                    print("Error updating user data: $error");
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  Widget _buildTextField({
    required String value,
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    TextInputType keyboardType = TextInputType.text,
  }) {
    controller.text = value;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter $label';
                }
                return null;
              },
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
    required ValueChanged<String?> onChanged,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          DropdownMenu<String>(
            width: double.infinity,
            menuHeight: 250,
            initialSelection: value,
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
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onSelected: (selectedValue) {
              onChanged(selectedValue);
            },
          ),
        ],
      ),
    );
  }
}