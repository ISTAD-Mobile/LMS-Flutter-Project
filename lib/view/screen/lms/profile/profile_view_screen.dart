// import 'package:flutter/material.dart';
// import 'package:lms_mobile/repository/student_profile_repository.dart';
// import 'package:provider/provider.dart';
// import '../../../../data/color/color_screen.dart';
// import '../../../../viewModel/student_profile_viewModel.dart';
//
// class ProfileScreen extends StatelessWidget {
//   final String token;
//
//   const ProfileScreen({required this.token, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) =>
//           StudenProfileDataViewModel(userRepository: StudentProfileRepository(
//               token: token)),
//       child: Scaffold(
//         backgroundColor: AppColors.defaultWhiteColor, // Keep scaffold white
//         body: SafeArea(
//           child: Container(
//             color: AppColors.backgroundColor, // Grey background for body
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Profile Info Title
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 20.0),
//                   child: const Text(
//                     'Your Profile Info',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                 ),
//                 // Main Profile Card
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 0.0),
//                   child: Card(
//                     color: AppColors.defaultWhiteColor,
//                     child: Padding(
//                       padding: const EdgeInsets.all(24.0),
//                       child: Consumer<StudenProfileDataViewModel>(
//                         builder: (context, viewModel, _) {
//                           // Trigger fetch user data if needed
//                           if (viewModel.user == null && !viewModel.isLoading &&
//                               viewModel.errorMessage == null) {
//                             viewModel.fetchUserData();
//                           }
//
//                           if (viewModel.isLoading) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           } else if (viewModel.errorMessage != null) {
//                             return Center(child: Text(
//                                 "Error: ${viewModel.errorMessage}"));
//                           } else if (viewModel.user == null) {
//                             return const Center(
//                                 child: Text("No user data found"));
//                           } else {
//                             final user = viewModel.user!;
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 70,
//                                   backgroundImage: user.profileImage != null &&
//                                       user.profileImage!.isNotEmpty
//                                       ? NetworkImage(user.profileImage!)
//                                       : const AssetImage(
//                                       'assets/images/placeholder.jpg') as ImageProvider,
//                                 ),
//                                 const SizedBox(height: 16),
//                                 Text(
//                                   user.nameEn,
//                                   style: const TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w500,
//                                     color: AppColors.primaryColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 const SizedBox(height: 20),
//                                 _buildProfileDetail('Degree:', user.degree),
//                                 const SizedBox(height: 16),
//                                 _buildProfileDetail('Date of Birth:', user.dob),
//                                 const SizedBox(height: 16),
//                                 _buildProfileDetail('Major:', user.major),
//                               ],
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileDetail(String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 18,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: AppColors.primaryColor,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 softWrap: true,
//                 overflow: TextOverflow.visible,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../viewModel/student_profile_viewModel.dart';

class ProfileScreen extends StatelessWidget {
  final String token;

  const ProfileScreen({required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudenProfileDataViewModel(
        userRepository: StudentProfileRepository(token: token),
      ),
      child: Scaffold(
        backgroundColor: AppColors.defaultWhiteColor,
        body: SafeArea(
          child: Container(
            color: AppColors.backgroundColor,
            child: SingleChildScrollView(  // Make the content scrollable
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
                  Consumer<StudenProfileDataViewModel>(
                    builder: (context, viewModel, _) {
                      if (viewModel.user == null &&
                          !viewModel.isLoading &&
                          viewModel.errorMessage == null) {
                        viewModel.fetchUserData();
                      }

                      if (viewModel.isLoading) {
                        return _buildSkeletonLoader();
                      } else if (viewModel.errorMessage != null) {
                        return Center(
                          child: Text("Error: ${viewModel.errorMessage}"),
                        );
                      } else if (viewModel.user == null) {
                        return const Center(child: Text("No user data found"));
                      } else {
                        final user = viewModel.user!;
                        return Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.defaultWhiteColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey[200],
                                foregroundImage: user.profileImage != null &&
                                    user.profileImage!.isNotEmpty
                                    ? NetworkImage(user.profileImage!)
                                    : null,
                                child: user.profileImage == null ||
                                    user.profileImage!.isEmpty
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
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Container(
              height: 20,
              width: 150,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            _buildSkeletonDetail(),
            const SizedBox(height: 16),
            _buildSkeletonDetail(),
            const SizedBox(height: 16),
            _buildSkeletonDetail(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonDetail() {
    return Row(
      children: [
        Container(
          height: 20,
          width: 80,
          color: Colors.grey[300],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 20,
            color: Colors.grey[300],
          ),
        ),
      ],
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