import 'package:flutter/material.dart';
import 'package:lms_mobile/view/home.dart';

import '../../../../data/color/color_screen.dart';

class EnrollSuccessfulScreen extends StatelessWidget {
  const EnrollSuccessfulScreen({super.key, required String course, required String classTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon
            Container(
              decoration: const BoxDecoration(
                color: Colors.green, // Green background
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(20),
              child: const Icon(
                Icons.check,
                size: 50,
                color: Colors.white, // White checkmark
              ),
            ),

            const SizedBox(height: 20),

            // Success Message
            const Text(
              'អ្នកបានចុះឈ្មោះដោយជោគជ័យ', // Replace with the appropriate Khmer text
              style: TextStyle(
                fontSize: 20,
                color: Colors.green, // Green text
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // Next Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
