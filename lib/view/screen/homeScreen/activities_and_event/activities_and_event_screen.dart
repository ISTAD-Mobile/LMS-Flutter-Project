import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

class ActivitiesAndEventScreen extends StatefulWidget {
  const ActivitiesAndEventScreen({super.key});

  @override
  State<ActivitiesAndEventScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ActivitiesAndEventScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.defaultGrayColor),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
        ),
        title: const Text(
          'Activities And Event',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
        ),
      ),
    );
  }
}