import 'package:flutter/material.dart';

import '../../../../data/color/color_screen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhitColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
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
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Large profile picture
                      const CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('assets/images/tevy.png'),
                      ),
                      const SizedBox(height: 16),

                      // Name
                      const Text(
                        'Mi sorakmony',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Bio
                      const Text(
                        'Bio: Flutter development',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Profile details
                      _buildProfileDetail('Gender:', 'Female'),
                      const SizedBox(height: 16),
                      _buildProfileDetail('Birth:', '15/08/2001'),
                      const SizedBox(height: 16),
                      _buildProfileDetail('Personal Number:', '0965990394'),
                    ],
                  ),
                ),
              ),
            ),
          ],
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