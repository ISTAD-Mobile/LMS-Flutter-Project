// import 'package:flutter/material.dart';
// import 'package:lms_mobile/view/screen/lms/profile/settings/profile_setting_screen.dart';
//
// import '../../../../../data/color/color_screen.dart';
//
//
// class StaticProfileViewScreen extends StatelessWidget {
//   const StaticProfileViewScreen({super.key});
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
//               // Profile Image
//               const Center(
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage('assets/images/tevy.png'),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Static Information Fields
//               _buildInfoField(label: 'Full Name (KH)', value: 'ញឹម ទេវី'),
//               _buildInfoField(label: 'Full Name (EN)', value: 'Nhoem Tevy'),
//               _buildInfoField(label: 'Gender', value: 'Female'),
//               _buildInfoField(label: 'Date Of Birth', value: '15/09/2004'),
//               _buildInfoField(label: 'Current Address', value: 'Kandel'),
//               _buildInfoField(label: 'Personal Number', value: '+855483058935'),
//               _buildInfoField(label: 'Family Number', value: '+855883058935'),
//
//               // Edit Button
//               const SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SettingScreen(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 38,
//                       vertical: 12,
//                     ),
//                     backgroundColor: AppColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12), // Adjust the radius value as needed
//                     ),
//                   ),
//                   child: const Text(
//                     'Edit',
//                     style: TextStyle(
//                       color: AppColors.defaultWhiteColor,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           ),
//         ),
//       );
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
import 'package:lms_mobile/view/screen/lms/profile/settings/profile_setting_screen.dart';
import 'package:lms_mobile/data/response/status.dart';
import '../../../../../data/color/color_screen.dart';
import 'package:intl/intl.dart';
import '../../../../../model/students_model/profile_setting_model.dart';
import '../../../../../viewModel/students_view_model/profile_setting_view_model.dart';

class StaticProfileViewScreen extends StatefulWidget {
  const StaticProfileViewScreen({super.key});

  @override
  State<StaticProfileViewScreen> createState() => _StaticProfileViewScreenState();
}

class _StaticProfileViewScreenState extends State<StaticProfileViewScreen> {
  final ProfileSettingViewModel _viewModel = ProfileSettingViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchProfileSetting();
  }

  String getGenderString(Gender gender) {
    return gender == Gender.M ? 'Male' : 'Female';
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      body: SafeArea(
        child: ChangeNotifierProvider<ProfileSettingViewModel>(
          create: (context) => _viewModel,
          child: Consumer<ProfileSettingViewModel>(
            builder: (context, viewModel, _) {
              switch (viewModel.profileSetting.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());

                case Status.ERROR:
                  return Center(
                    child: Text(viewModel.profileSetting.message ?? 'Error occurred'),
                  );
                case Status.COMPLETED:
                  final profile = viewModel.profileSetting.data!.content.first; // Getting first student profile
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
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
                        // Profile Image
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: profile.profileImage.isNotEmpty == true
                                ? NetworkImage(profile.profileImage) as ImageProvider
                                : const AssetImage('assets/images/tevy.png'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Dynamic Information Fields
                        _buildInfoField(
                            label: 'Full Name (KH)',
                          value: profile.nameKh ?? 'N/A',

                        ),
                        _buildInfoField(
                            label: 'Full Name (EN)',
                            value: profile.nameEn ?? 'N/A',
                        ),
                        _buildInfoField(
                            label: 'Gender',
                            value: getGenderString(profile.gender ?? Gender.M) // Provide a default
                        ),
                        _buildInfoField(
                            label: 'Date Of Birth',
                            value: formatDate(profile.dob)
                        ),
                        _buildInfoField(
                            label: 'Current Address',
                            value: profile.currentAddress?.isNotEmpty == true
                                ? profile.currentAddress!
                                : 'N/A'
                        ),
                        _buildInfoField(
                            label: 'Personal Number',
                            value: profile.phoneNumber ?? 'N/A'
                        ),
                        _buildInfoField(
                            label: 'Family Number',
                            value: profile.familyPhoneNumber ?? 'N/A'
                        ),
                        _buildInfoField(
                            label: 'Email',
                            value: profile.email ?? 'N/A'
                        ),
                        // Edit Button
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
                              ).then((_) {
                                // Refresh data when returning from edit screen
                                _viewModel.fetchProfileSetting();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 38,
                                vertical: 12,
                              ),
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                color: AppColors.defaultWhiteColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                default:
                  return const Center(child: Text('No data available'));
              }
            },
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