import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms_mobile/viewModel/enroll/current_address_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/place_of_birth_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/university_view_model.dart';
import '../../../../model/enrollmentRequest/register_model.dart';

class EnrollmentStateNotifier extends ChangeNotifier {
  int _currentStep = 0;
  EnrollmentModel? _enrollmentData;

  int get currentStep => _currentStep;
  EnrollmentModel? get enrollmentData => _enrollmentData;

  void setStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void updateEnrollmentData(EnrollmentModel data) {
    _enrollmentData = data;
    notifyListeners();
  }
}

class EnrollmentProvider extends StatelessWidget {
  final Widget child;

  const EnrollmentProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EnrollmentStateNotifier()),
        ChangeNotifierProvider(create: (_) => PlaceOfBirthViewModel()),
        ChangeNotifierProvider(create: (_) => CurrentAddressViewModel()),
        ChangeNotifierProvider(create: (_) => UniversityViewModel()),
      ],
      child: child,
    );
  }
}