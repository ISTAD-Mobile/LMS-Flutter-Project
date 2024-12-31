// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:lms_mobile/view/screen/lms/profile/settings/profile_setting_screen.dart';
// import '../../../../../data/color/color_screen.dart';
//
// class StaticProfileViewScreen extends StatefulWidget {
//   final String accessToken;
//
//   const StaticProfileViewScreen({required this.accessToken, super.key});
//
//   @override
//   _StaticProfileViewScreenState createState() =>
//       _StaticProfileViewScreenState();
// }
//
// class _StaticProfileViewScreenState extends State<StaticProfileViewScreen> {
//   bool isLoading = true;
//   Map<String, dynamic>? userData;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }
//
//   Future<void> fetchUserData() async {
//     Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/setting");
//
//     try {
//       var response = await http.get(
//         url,
//         headers: {
//           "Authorization": "Bearer ${widget.accessToken}",
//         },
//       );
//
//       if (response.statusCode == 200) {
//         setState(() {
//           userData = jsonDecode(response.body); // Decode the JSON response
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = "Failed to fetch user data: ${response.statusCode}";
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error fetching user data: $e";
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.defaultWhiteColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Student Setting',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : userData == null
//                   ? Center(child: Text(errorMessage))
//                   : Column(
//                 children: [
//                   CircleAvatar(
//                   radius: 50,
//                   backgroundImage: userData?['profileImage'] != null
//                       ? NetworkImage(userData!['profileImage'])
//                       : const AssetImage('assets/images/placeholder.jpg'),
//                   ),
//
//                const SizedBox(height: 20),
//
//                   _buildInfoField(
//                     label: 'Full Name (KH)',
//                     value: userData?['fullNameKh'] ?? 'N/A',
//                   ),
//                   _buildInfoField(
//                     label: 'Full Name (EN)',
//                     value: userData?['fullNameEn'] ?? 'N/A',
//                   ),
//                   _buildInfoField(
//                     label: 'Gender',
//                     value: userData?['gender'] == 'F' ? 'Female' : 'Male',
//                   ),
//                   _buildInfoField(
//                     label: 'Date Of Birth',
//                     value: userData?['dob'] ?? 'N/A',
//                   ),
//                   _buildInfoField(
//                     label: 'Current Address',
//                     value: userData?['currentAddress'] ?? 'N/A',
//                   ),
//                   _buildInfoField(
//                     label: 'Personal Number',
//                     value: userData?['phoneNumber'] ?? 'N/A',
//                   ),
//                   _buildInfoField(
//                     label: 'Family Number',
//                     value: userData?['familyPhoneNumber'] ?? 'N/A',
//                   ),
//                   // Edit Button
//                   const SizedBox(height: 20),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const SettingScreen(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 38,
//                           vertical: 12,
//                         ),
//                         backgroundColor: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'Edit',
//                         style: TextStyle(
//                           color: AppColors.defaultWhiteColor,
//                           fontSize: 16.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoField({required String label, required String value}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               color: AppColors.primaryColor,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.white,
//             ),
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/color/color_screen.dart';
import '../../../../../repository/student_profile_setting_repository.dart';
import '../../../../../viewModel/student_profile_setting_viewmodel.dart';
import 'profile_setting_screen.dart';

class StaticProfileViewScreen extends StatelessWidget {
  final String accessToken;

  const StaticProfileViewScreen({required this.accessToken, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentSettingViewModel(repository: StudentSettingRepository(accessToken: accessToken))..fetchUserData(),
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
                            : const AssetImage('assets/images/placeholder.jpg') as ImageProvider,
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
                              builder: (context) => const SettingScreen(),
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

