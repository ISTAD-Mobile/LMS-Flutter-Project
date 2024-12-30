// import 'package:flutter/material.dart';
// import '../../../../data/color/color_screen.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key, required String accessToken});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.defaultWhiteColor, // Keep scaffold white
//       body: SafeArea(
//         child: Container(
//           // Add Container for body background
//           color: AppColors.backgroundColor, // Grey background for body
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Profile Info Title
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//                 child: const Text(
//                   'Your Profile Info',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//               ),
//
//               // Main Profile Card
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
//                 child: Card(
//                   color: AppColors.defaultWhiteColor,
//                   child: Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const CircleAvatar(
//                           radius: 70,
//                           backgroundImage: AssetImage('assets/images/tevy.png'),
//                         ),
//                         const SizedBox(height: 16),
//
//                         const Text(
//                           'Mi sorakmony',
//                           style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w500,
//                               color: AppColors.primaryColor
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//
//                         const Text(
//                           'Bio: Flutter development',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 18,
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//
//                         _buildProfileDetail('Gender:', 'Female'),
//                         const SizedBox(height: 16),
//                         _buildProfileDetail('Birth:', '15/08/2001'),
//                         const SizedBox(height: 16),
//                         _buildProfileDetail('Personal Number:', '0965990394'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileDetail(String label, String value) {
//     return Row(
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 18,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 18,
//             color: AppColors.primaryColor,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ],
//     );
//   }
// }


//
// import 'package:flutter/material.dart';
// import 'package:lms_mobile/repository/student_profile_repository.dart';
// import 'package:provider/provider.dart';
// import '../../../../data/color/color_screen.dart';
// import '../../../../viewModel/login_student_viewModel.dart';
//
// class ProfileScreen extends StatelessWidget {
//   final String accessToken;
//
//   const ProfileScreen({required this.accessToken, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => StudenProfileViewModel(StudentProfileRepository(accessToken: accessToken)),
//       child: Scaffold(
//         backgroundColor: AppColors.defaultWhiteColor, // Keep scaffold white
//         body: SafeArea(
//           child: Container(
//             // Add Container for body background
//             color: AppColors.backgroundColor, // Grey background for body
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Profile Info Title
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
//                   child: Card(
//                     color: AppColors.defaultWhiteColor,
//                     child: Padding(
//                       padding: const EdgeInsets.all(24.0),
//                       child: Consumer<StudentProfileViewmodel>(
//                         builder: (context, viewModel, _) {
//                           // Trigger fetch user data if needed
//                           if (viewModel.user == null && !viewModel.isLoading && viewModel.errorMessage == null) {
//                             viewModel.fetchUserData(accessToken);
//                           }
//
//                           if (viewModel.isLoading) {
//                             return const Center(child: CircularProgressIndicator());
//                           } else if (viewModel.errorMessage != null) {
//                             return Center(child: Text("Error: ${viewModel.errorMessage}"));
//                           } else if (viewModel.user == null) {
//                             return const Center(child: Text("No user data found"));
//                           } else {
//                             final user = viewModel.user!;
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 70,
//                                   backgroundImage: user.profileImage != null
//                                       ? NetworkImage(user.profileImage!)
//                                       : const AssetImage('assets/default_avatar.png') as ImageProvider, // Fallback image
//                                 ),
//                                 const SizedBox(height: 16),
//                                 Text(
//                                   user.nameEn,
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w500,
//                                     color: AppColors.primaryColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   'Bio: ${user.major}', // You can change this to any bio or additional info
//                                   style: const TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 40),
//                                 _buildProfileDetail('Degree:', user.degree),
//                                 const SizedBox(height: 16),
//                                 _buildProfileDetail('Date of Birth:', user.dob),
//                                 const SizedBox(height: 16),
//                                 _buildProfileDetail('Avatar:', user.avatar ?? 'No Avatar'),
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
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 18,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 18,
//             color: AppColors.primaryColor,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../viewModel/login_student_viewModel.dart';

class ProfileScreen extends StatelessWidget {
  final String accessToken;

  const ProfileScreen({required this.accessToken, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudenProfileDataViewModel(userRepository: StudentProfileRepository(accessToken: accessToken)),
      child: Scaffold(
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
                // Main Profile Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                  child: Card(
                    color: AppColors.defaultWhiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Consumer<StudenProfileDataViewModel>( // Fixed the typo in the ViewModel name
                        builder: (context, viewModel, _) {
                          // Trigger fetch user data if needed
                          if (viewModel.user == null && !viewModel.isLoading && viewModel.errorMessage == null) {
                            viewModel.fetchUserData();
                          }

                          if (viewModel.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (viewModel.errorMessage != null) {
                            return Center(child: Text("Error: ${viewModel.errorMessage}"));
                          } else if (viewModel.user == null) {
                            return const Center(child: Text("No user data found"));
                          } else {
                            final user = viewModel.user!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage: user.profileImage != null
                                      ? NetworkImage(user.profileImage!)
                                      : const AssetImage('assets/default_avatar.png') as ImageProvider, // Fallback image
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  user.nameEn,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Bio: ${user.major}', // You can change this to any bio or additional info
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                _buildProfileDetail('Degree:', user.degree),
                                const SizedBox(height: 16),
                                _buildProfileDetail('Date of Birth:', user.dob),
                                const SizedBox(height: 16),
                                _buildProfileDetail('Avatar:', user.avatar ?? 'No Avatar'),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
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
