import '../../data/network/enrollment_service.dart';
import '../../model/enrollmentRequest/register_model.dart';
import '../../resource/app_url.dart';

class EnrollmentRepository {
  final EnrollmentService _service;

  EnrollmentRepository(this._service);

  Future<EnrollmentModel> postEnrollment(EnrollmentModel enrollment) async {
    try {
      final enrollmentRequest = enrollmentModelToJson(enrollment);
      final response = await _service.postEnrollment(
          AppUrl.postBlogRegisterUrl,
          enrollmentRequest
      );

      if (response != null) {
        return EnrollmentModel.fromJson(response);
      } else {
        throw Exception('Failed to load enrollment data');
      }
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}

// class EnrollmentRepository {
//   var enrollmentService = EnrollmentService();
//
//   Future<EnrollmentModel> postEnrollment(Map<String, dynamic> data) async {
//     try {
//       var enrollmentRequest = enrollmentModelToJson(data as EnrollmentModel);
//
//       dynamic response = await enrollmentService.postEnrollment(
//           AppUrl.postBlogRegisterUrl, enrollmentRequest);
//
//       if (response != null) {
//         return EnrollmentModel.fromJson(response);
//       } else {
//         throw Exception('Failed to load enrollment data');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }


