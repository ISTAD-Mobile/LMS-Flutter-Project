import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import 'package:lms_mobile/viewModel/student_profile_viewmodel.dart';

import '../../../../data/response/status.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StudentProfileViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor, // Keep scaffold white
      body: SafeArea(
        child: Container(
          color: AppColors.backgroundColor, // Grey background for body
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Info Title
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: const Text(
                  'Your Profile Info',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              // Main Body Content
              Expanded(
                child: Builder(
                  builder: (context) {
                    final response = viewModel.response;

                    // Handle API response
                    if (response.status == Status.LOADING) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (response.status == Status.ERROR) {
                      return Center(
                        child: Text(
                          "Error: ${response.message}",
                          style: const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      );
                    } else if (response.status == Status.COMPLETED) {
                      final studentProfile = response.data!;
                      final student = studentProfile.content.first; // Assuming the first student is displayed

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                        child: Card(
                          color: AppColors.defaultWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(student.profileImage),
                                ),
                                const SizedBox(height: 16),

                                Text(
                                  student.nameEn,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Text(
                                  "Bio: ${student.biography}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 40),

                                _buildProfileDetail('Gender:', student.gender),
                                const SizedBox(height: 16),
                                _buildProfileDetail('Birth:', _formatDate(student.dob)),
                                const SizedBox(height: 16),
                                _buildProfileDetail('Personal Number:', student.phoneNumber),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: Text("No data available."));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to format date
  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  // Reusable widget for profile details
  Widget _buildProfileDetail(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
