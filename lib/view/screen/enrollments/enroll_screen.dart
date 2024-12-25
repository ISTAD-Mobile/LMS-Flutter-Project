import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/public_screen_widgets/enrollments_widget/enroll_step1.dart';
import '../../widgets/public_screen_widgets/enrollments_widget/enroll_step2.dart';
import '../../widgets/public_screen_widgets/enrollments_widget/enroll_step3.dart';
import '../../widgets/public_screen_widgets/enrollments_widget/enrollment_provider.dart';

class EnrollScreen extends StatefulWidget {
  const EnrollScreen({super.key});

  @override
  _EnrollScreen createState() => _EnrollScreen();
}

class _EnrollScreen extends State<EnrollScreen> {
  final List<Widget> _steps = [
    const EnrollStep1(),
    const EnrollStep2(),
    const EnrollStep3(),
  ];

  @override
  Widget build(BuildContext context) {
    return EnrollmentProvider(
      child: Consumer<EnrollmentStateNotifier>(
        builder: (context, enrollmentState, _) => Scaffold(
          body: Column(
            children: [
              Expanded(
                child: _steps[enrollmentState.currentStep],
              ),
            ],
          ),
        ),
      ),
    );
  }
}