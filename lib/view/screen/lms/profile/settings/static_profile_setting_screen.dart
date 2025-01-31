import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../data/color/color_screen.dart';
import '../../../../../repository/student_profile_setting_repository.dart';
import '../../../../../viewModel/student_profile_setting_viewmodel.dart';
import 'profile_setting_screen.dart';

class StaticProfileViewScreen extends StatefulWidget {
  final String token;
  final Widget? drawer;
  final Function() refreshCallback;

  const StaticProfileViewScreen({
    required this.token,
    required this.refreshCallback,
    this.drawer,
    super.key,
  });

  @override
  _StaticProfileViewScreenState createState() => _StaticProfileViewScreenState();
}

class _StaticProfileViewScreenState extends State<StaticProfileViewScreen> {
  bool _showBackIcon = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentSettingViewModel(
        repository: StudentSettingRepository(token: widget.token),
      )..fetchUserData(),
      child: Scaffold(
        backgroundColor: AppColors.defaultWhiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.defaultWhiteColor,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: _showBackIcon,
          title: const Text(
            'Student Setting',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
            ),
          ),
        ),
        drawer: widget.drawer,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<StudentSettingViewModel>(
                  builder: (context, viewModel, child) {
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

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: userData.profileImage != null
                                ? NetworkImage(userData.profileImage!)
                                : const AssetImage('assets/images/placeholder.jpg') as ImageProvider,
                            child: userData.profileImage == null
                                ? const Icon(Icons.person)
                                : null,
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
                                  builder: (context) => SettingScreen(
                                    token: widget.token,
                                  ),
                                ),
                              ).then((_) {
                                setState(() {
                                  _showBackIcon = false; // Ensure the back icon remains hidden
                                });
                                widget.refreshCallback();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                color: AppColors.defaultWhiteColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => SettingScreen(
                          //           token: widget.token,
                          //         ),
                          //       ),
                          //     ).then((_) {
                          //       setState(() {
                          //         _showBackIcon = true;
                          //       });
                          //       widget.refreshCallback();
                          //     });
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //     padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
                          //     backgroundColor: AppColors.primaryColor,
                          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          //   ),
                          //   child: const Text(
                          //     'Edit',
                          //     style: TextStyle(
                          //       color: AppColors.defaultWhiteColor,
                          //       fontSize: 16.0,
                          //     ),
                          //   ),
                          // ),
                        ),
                      ],
                    );
                  },
                ),
              ],
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