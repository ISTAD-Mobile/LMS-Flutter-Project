import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

import '../../widgets/public_screen_widgets/enrollments_widget/enroll_step1.dart';


class EnrollScreen extends StatefulWidget {
  const EnrollScreen({super.key});

  @override
  _EnrollScreen createState() => _EnrollScreen();
}

class _EnrollScreen extends State<EnrollScreen> {
  int _currentStep = 0;

  final List<Widget> _steps = [
    EnrollStep1(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        title: const Text(
          'Enrollment Screen',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _steps[_currentStep]),
        ],
      ),
    );
  }
}
