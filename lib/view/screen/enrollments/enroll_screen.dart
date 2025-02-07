import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/public_screen_widgets/enrollments_widget/enroll_step1.dart';
import '../../widgets/public_screen_widgets/enrollments_widget/enroll_step2.dart';
import '../../widgets/public_screen_widgets/enrollments_widget/enroll_step3.dart';
import '../../widgets/public_screen_widgets/enrollments_widget/enrollment_provider.dart';


class EnrollScreen extends StatefulWidget {
  final String id;
  const EnrollScreen({super.key,required this.id});

  @override
  State<EnrollScreen> createState() => _EnrollScreenState();
}

class _EnrollScreenState extends State<EnrollScreen> {
  late final List<Widget> _steps;

  late String id;
  @override
  void initState() {
    super.initState();
    _steps = [
      EnrollStep1(),
      EnrollStep2(),
      EnrollStep3(studentId: id, classId: '',),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EnrollmentStateNotifier>(
      create: (context) => EnrollmentStateNotifier(),
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