import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_mobile/view/screen/lms/profile/settings/static_profile_setting_screen.dart';
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

  get refreshCallback => null;

  @override
  _StudentSettingsState createState() => _StudentSettingsState(token: token);
}

class _StudentSettingsState extends State<SettingScreen> {
  final String token;
  _StudentSettingsState({required this.token});

  late UpdataStudentProfileSettingViewmodel viewModel;
  late Future<StudentSettingModel> _futureAlbum;

  File? _image;
  final _formKey = GlobalKey<FormState>();

  final _bioController = TextEditingController();
  final _currentAddressController = TextEditingController();
  final _personalNumberController = TextEditingController();
  final _familyNumberController = TextEditingController();
  final _placeOfBirthController = TextEditingController();

  final bioFocus = FocusNode();
  final currentAddressFocus = FocusNode();
  final personalNumberFocus = FocusNode();
  final familyNumberFocus = FocusNode();
  final placeOfBirthFocus = FocusNode();
  final List<String> genderOptions = ['Female', 'Male', 'Other'];
  final List<String> guardianRelationshipOptions = ['Mother', 'Father', 'Sibling', 'Other'];

  @override
  void initState() {
    super.initState();
    viewModel = UpdataStudentProfileSettingViewmodel(
      repository: UpdateStudentProfileSettingRepository(token: widget.token),
    );
    viewModel.fetchUserData();
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage));
          } else if (viewModel.userData == null) {
            return const Center(child: Text('No user data available'));
          }

          final userData = viewModel.userData!;

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
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: isImageUploade.isNotEmpty
                                  ? NetworkImage(isImageUploade)
                                  : (userData.profileImage != null && userData.profileImage!.isNotEmpty
                                  ? NetworkImage(userData.profileImage!)
                                  : const AssetImage('assets/images/placeholder.jpg')),
                              onBackgroundImageError: (_, __) {
                                // Handle any image loading errors
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
                      _buildDropdownField(
                        label: 'Gender',
                        value: userData.gender.isEmpty && genderOptions.contains(userData.gender)
                            ? userData.gender
                            : 'Female',
                        items: genderOptions,
                        onChanged: (value) {
                          setState(() {
                            userData.gender = value ?? 'Male';
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
                        label: 'GuardianRelationship',
                        value: userData.guardianRelationShip.isEmpty && guardianRelationshipOptions.contains(userData.guardianRelationShip)
                            ? userData.guardianRelationShip
                            : 'Other',
                        items: guardianRelationshipOptions,
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
                            // Cancel Button
                            OutlinedButton(
                              onPressed: () {
                                // Reset the form fields to their original values (clear user input)
                                _personalNumberController.text = userData.phoneNumber ?? '';
                                _familyNumberController.text = userData.familyPhoneNumber ?? '';
                                _bioController.text = userData.biography ?? '';
                                _currentAddressController.text = userData.currentAddress ?? '';
                                _placeOfBirthController.text = userData.birthPlace ?? '';

                                // Optionally, reset other fields or values related to image upload or changes if needed
                                isImageUploade = '';  // Reset the image upload state if necessary
                                // setState(() {});
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => StaticProfileViewScreen(token: widget.token, refreshCallback: () {  },)),
                                // );
                                Navigator.pop(context);
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
                                      profileImage: isImageUploade.isNotEmpty
                                          ? isImageUploade
                                          : userData.profileImage ?? '',
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Your data has been saved successfully!')),
                                    );

                                    // Call the refresh callback
                                    widget.refreshCallback?.call();

                                    Navigator.pop(context);
                                  } catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Failed to save data. Please try again.')),
                                    );
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
                              child: const Text('Save',
                                style: TextStyle(color: AppColors.defaultWhiteColor, fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            onSelected: onChanged,
          ),
        ],
      ),
    );
  }
}