import 'dart:convert';

import '../../data/network/enrollment_service.dart';
import '../../model/enrollmentRequest/enroll.dart';
import '../../resource/app_url.dart';

class EnrollRepository {
  final EnrollmentService _service;

  EnrollRepository(this._service);

  Future<EnrollModel> postEnroll(EnrollModel enroll) async {
    try {
      final enrollRequest = jsonEncode(enroll.toJson());
      final response = await _service.postEnrollment(
          AppUrl.postBlogEnrollmentUrl,
          enrollRequest
      );

      if (response != null) {
        return EnrollModel.fromJson(response);
      } else {
        throw Exception('Failed to load enroll data');
      }
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}

// class EnrollStep3Repo {
//   var enrollmentService = EnrollmentService();
//
//   Future<EnrollModel> postEnroll(Map<String, dynamic> data) async {
//     try {
//       var enrollRequest = enrollModelToJson(data as EnrollModel);
//
//       dynamic response = await enrollmentService.postEnrollment(
//           AppUrl.postBlogEnrollmentUrl, enrollRequest);
//
//       if (response != null) {
//         return EnrollModel.fromJson(response);
//       } else {
//         throw Exception('Failed to load enrollment data');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }