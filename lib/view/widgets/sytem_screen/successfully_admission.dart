import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/color/color_screen.dart';
import '../../home.dart';

class SuccessfullyAdmissionPage extends StatelessWidget {
  final String telegramLink;
  final String studentName;

  SuccessfullyAdmissionPage({required this.telegramLink, required this.studentName});

  // Function to launch the URL
  Future<void> _launchURL() async {
    final uri = Uri.parse(telegramLink);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $telegramLink';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  'assets/images/istad-logo-white.png',
                  height: 37,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _buildAdmissionButton(context),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animation/Successfully.json',
                    width: 150,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const Text(
                    'អ្នកបានចុះឈ្មោះបានដោយជោគជ័យ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansKhmer',
                      color: AppColors.successColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'សូមស្វាគមន៍ $studentName អ្នកបានចុះឈ្មោះជោគជ័យ។ សូមចុចតំណភ្ជាប់ (link) ឬ ស្កេន QR ដើម្បីចូលទៅកាន់គ្រុបតេលេក្រាមនិងតាមដានព័ត៌មានសិក្សា',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'NotoSansKhmer',
                      color: AppColors.defaultGrayColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _launchURL,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonTelegramColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.string(
                          '''<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32"><path fill="currentColor" d="m29.919 6.163l-4.225 19.925c-.319 1.406-1.15 1.756-2.331 1.094l-6.438-4.744l-3.106 2.988c-.344.344-.631.631-1.294.631l.463-6.556L24.919 8.72c.519-.462-.113-.719-.806-.256l-14.75 9.288l-6.35-1.988c-1.381-.431-1.406-1.381.288-2.044l24.837-9.569c1.15-.431 2.156.256 1.781 2.013z"/></svg>''',
                          height: 24,
                          width: 24,
                          color: AppColors.defaultWhiteColor,
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Join Telegram Group',
                          style: TextStyle(fontSize: 17, color: AppColors.defaultWhiteColor),
                        ),
                        const SizedBox(width: 15),
                        const Icon(Icons.arrow_forward_ios, color: AppColors.defaultWhiteColor),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Admission button widget
  Widget _buildAdmissionButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => RegisterStep1(),
        //   ),
        // );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        minimumSize: const Size(120, 33),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            'https://cdn-icons-png.flaticon.com/128/684/684872.png',
            width: 18,
            height: 18,
            color: Colors.white,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 4),
          const Text(
            'ADMISSION',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
