import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';

import '../../repository/enroll/enroll_repository.dart';

// class EnrollmentViewModel extends ChangeNotifier {
//   final _enrollRepository = EnrollRepository();
//   var response = ApiResponse();
//
//   setEnrollmentData(response) {
//     this.response = response;
//     notifyListeners();
//
//     Future<dynamic> postEnrollment(data) async {
//       await _enrollRepository.postEnrollment(data)
//           .then((value) => setEnrollmentData(ApiResponse.completed(value)))
//           .onError((error, stackTrace) =>
//           setEnrollmentData(ApiResponse.error(stackTrace.toString())));
//     }
//   }
// }

class EnrollmentViewModel extends ChangeNotifier {
  final _enrollRepository = EnrollRepository();
  ApiResponse response = ApiResponse.loading();

  void setEnrollmentData(ApiResponse newResponse) {
    response = newResponse;
    notifyListeners();
  }

  Future<void> postEnrollment(Map<String, dynamic> data) async {
    setEnrollmentData(ApiResponse.loading());
    try {
      final value = await _enrollRepository.postEnrollment(data);
      setEnrollmentData(ApiResponse.completed(value));
    } catch (error, stackTrace) {
      setEnrollmentData(ApiResponse.error(error.toString()));
      // Optionally log stackTrace for debugging
    }
  }
}

