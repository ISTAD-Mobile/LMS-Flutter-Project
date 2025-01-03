import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';

import '../../repository/enroll/enroll_repository.dart';

class EnrollmentViewModel extends ChangeNotifier {
  final _enrollRepository = EnrollRepository();
  ApiResponse enrollment = ApiResponse.loading();

  void setEnrollmentData(ApiResponse newEnrollment) {
    enrollment = newEnrollment;
    notifyListeners();
  }

  Future<void> postEnrollment(Map<String, dynamic> data) async {
    setEnrollmentData(ApiResponse.loading());
    try {
      final value = await _enrollRepository.postEnrollment(data);
      setEnrollmentData(ApiResponse.completed(value));
    } catch (error, stackTrace) {
      setEnrollmentData(ApiResponse.error(error.toString()));
    }
  }
}

