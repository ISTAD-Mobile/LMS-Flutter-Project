import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/color/color_screen.dart';
import '../../../../../repository/student_profile_setting_repository.dart';
import '../../../../../viewModel/student_profile_setting_viewmodel.dart';
import 'profile_setting_screen.dart';

class StaticProfileViewScreen extends StatelessWidget {
  final String token;

  const StaticProfileViewScreen({required this.token, super.key, required Null Function() refreshCallback});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentSettingViewModel(
          repository: StudentSettingRepository(token: token))..fetchUserData(),
      child: Scaffold(
        backgroundColor: AppColors.defaultWhiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Consumer<StudentSettingViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (viewModel.errorMessage.isNotEmpty) {
                  return Center(child: Text(viewModel.errorMessage));
                } else if (viewModel.userData == null) {
                  return const Center(child: Text('No user data available'));
                }

                final userData = viewModel.userData!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Student Setting',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: userData.profileImage != null
                            ? NetworkImage(userData.profileImage!)
                            : const AssetImage('assets/images/placeholder.jpg'),
                        child: userData.profileImage == null ? Icon(Icons.person) : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInfoField(label: 'Gender', value: userData.gender),
                    _buildInfoField(label: 'Place Of Birth', value: userData.birthPlace),
                    _buildInfoField(label: 'Current Address', value: userData.currentAddress),
                    _buildInfoField(label: 'Personal Number', value: userData.phoneNumber),
                    _buildInfoField(label: 'Family Number', value: userData.familyPhoneNumber),
                    _buildInfoField(label: 'Biography', value: userData.biography),
                    _buildInfoField(label: 'GuardianRelationship', value: userData.guardianRelationShip),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingScreen(token: token),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: AppColors.defaultWhiteColor, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}