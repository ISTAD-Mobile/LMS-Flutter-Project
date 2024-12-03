import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/lms/profile/settings/profile_setting_screen.dart';

import '../../../../../data/color/color_screen.dart';


class StaticProfileViewScreen extends StatelessWidget {
  const StaticProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/tevy.png'),
                ),
              ),
              const SizedBox(height: 20),

              // Static Information Fields
              _buildInfoField(label: 'Full Name (KH)', value: 'ញឹម ទេវី'),
              _buildInfoField(label: 'Full Name (EN)', value: 'Nhoem Tevy'),
              _buildInfoField(label: 'Gender', value: 'Female'),
              _buildInfoField(label: 'Date Of Birth', value: '15/09/2004'),
              _buildInfoField(label: 'Current Address', value: 'Kandel'),
              _buildInfoField(label: 'Personal Number', value: '+855483058935'),
              _buildInfoField(label: 'Family Number', value: '+855883058935'),

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
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 38,
                      vertical: 12,
                    ),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Adjust the radius value as needed
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