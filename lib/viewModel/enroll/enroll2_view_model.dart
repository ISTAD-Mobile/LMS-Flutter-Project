import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/enroll/enroll_step2_repo.dart';
import '../../data/response/api_response.dart';

class EnrollStep2ViewModel extends ChangeNotifier {
  final _enrollmentStep2Repository = EnrollStep2Repo();
  ApiResponse<Map<String, dynamic>> responseEnrollStep2 = ApiResponse.loading();

  setEnrollmentData(ApiResponse<Map<String, dynamic>> responseEnrollStep2) {
    this.responseEnrollStep2 = responseEnrollStep2;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> postEnrollmentStep2(data) async {
    setEnrollmentData(ApiResponse.loading());

    try {
      final response = await _enrollmentStep2Repository.postEnrollmentStep2(data);

      setEnrollmentData(ApiResponse.completed(response));
      return response;
    } catch (error) {
      setEnrollmentData(ApiResponse.error(error.toString()));
      return null;
    }
  }
}

