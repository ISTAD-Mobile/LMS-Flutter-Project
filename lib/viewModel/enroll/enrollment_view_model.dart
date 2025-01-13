import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import '../../repository/enroll/enroll_repository.dart';

class EnrollmentViewModel extends ChangeNotifier {
  final _enrollRepository = EnrollRepository();
  var response = ApiResponse.loading();

  setEnrollmentData(ApiResponse response) {
    this.response = response;
    notifyListeners();
  }

  Future<void> postEnrollment(Map<String, dynamic> data) async {
    await _enrollRepository.postEnrollment(data)
        .then((value) {
      setEnrollmentData(ApiResponse.completed(value));  // 'value' is of type EnrollmentModel
    })
        .onError((error, stackTrace) {
      setEnrollmentData(ApiResponse.error(error.toString()));
    });
  }
}
