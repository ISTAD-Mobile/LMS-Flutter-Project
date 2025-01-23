import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../viewModel/student_profile_viewModel.dart';

class ProfileScreen extends StatelessWidget {
  final String token;

  const ProfileScreen({required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          StudenProfileDataViewModel(userRepository: StudentProfileRepository(
              token: token)),
      child: Scaffold(
        backgroundColor: AppColors.defaultWhiteColor,
        body: SafeArea(
          child: Container(
            color: AppColors.backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Info Title
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: const Text(
                    'Your Profile Info',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Consumer<StudenProfileDataViewModel>(
                  builder: (context, viewModel, _) {
                    if (viewModel.user == null && !viewModel.isLoading &&
                        viewModel.errorMessage == null) {
                      viewModel.fetchUserData();
                    }

                    if (viewModel.isLoading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/animation/loading.json',
                          width: 100,
                          height: 100,
                        ),
                      );
                    } else if (viewModel.errorMessage != null) {
                      return Center(child: Text(
                          "Error: ${viewModel.errorMessage}"));
                    } else if (viewModel.user == null) {
                      return const Center(
                          child: Text("No user data found"));
                    } else {
                      final user = viewModel.user!;
                      return Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(right: 16,left: 16),
                        // color: AppColors.defaultGrayColor,
                        decoration: BoxDecoration(
                          color: AppColors.defaultWhiteColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.grey[200], // Placeholder color
                              foregroundImage: user.profileImage != null && user.profileImage!.isNotEmpty
                                  ? NetworkImage(user.profileImage!)
                                  : null,
                              child: user.profileImage == null || user.profileImage!.isEmpty
                                  ? Image.asset('assets/images/placeholder.jpg')
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              user.nameEn,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const SizedBox(height: 20),
                            _buildProfileDetail('Degree:', user.degree),
                            const SizedBox(height: 16),
                            _buildProfileDetail('Date of Birth:', user.dob),
                            const SizedBox(height: 16),
                            _buildProfileDetail('Major:', user.major),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ],
    );
  }
}