import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/public_screen_widgets/enrollments_widget/enroll_step1.dart';
import '../../widgets/public_screen_widgets/enrollments_widget/enroll_step2.dart';
import '../../widgets/public_screen_widgets/enrollments_widget/enroll_step3.dart';
import 'enrollment_provider.dart' as screen_provider;


class EnrollScreen extends StatefulWidget {
  const EnrollScreen({super.key});

  @override
  State<EnrollScreen> createState() => _EnrollScreenState();
}

class _EnrollScreenState extends State<EnrollScreen> {
  late final List<Widget> _steps;

  @override
  void initState() {
    super.initState();
    final formData = screen_provider.EnrollmentFormData();
    _steps = [
      EnrollStep1(formData: formData),
      EnrollStep2(formData: screen_provider.EnrollmentFormData()),
      EnrollStep3(formData: formData, uuid: '',),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<screen_provider.EnrollmentStateNotifier>(
      create: (context) => screen_provider.EnrollmentStateNotifier(),
      child: Consumer<screen_provider.EnrollmentStateNotifier>(
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