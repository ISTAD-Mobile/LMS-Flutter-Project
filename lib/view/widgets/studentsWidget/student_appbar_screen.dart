import 'package:flutter/material.dart';

import '../../../data/color/color_screen.dart';


void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen()));
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/tevy.png'),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo_log_in.png',
                        width: 90,
                        height: 90,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}