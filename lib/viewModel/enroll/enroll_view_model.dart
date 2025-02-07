import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/enroll/enroll_repository.dart';
import '../../data/response/api_response.dart';

class EnrollViewModel extends ChangeNotifier {
  final _enrollmentRepository = EnrollRepository();
  ApiResponse<Map<String, dynamic>> responseEnroll = ApiResponse.loading();

  setEnrollmentData(ApiResponse<Map<String, dynamic>> responseEnroll) {
    this.responseEnroll = responseEnroll;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> postEnrollment(data) async {
    setEnrollmentData(ApiResponse.loading());

    try {
      final response = await _enrollmentRepository.postEnrollment(data);

      setEnrollmentData(ApiResponse.completed(response));
      return response;
    } catch (error) {
      setEnrollmentData(ApiResponse.error(error.toString()));
      return null;
    }
  }
}

