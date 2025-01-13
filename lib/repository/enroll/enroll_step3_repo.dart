import '../../data/network/enrollment_service.dart';
import '../../model/enrollmentRequest/enroll.dart';
import '../../resource/app_url.dart';

class EnrollStep3Repo {
  var enrollmentService = EnrollmentService();

  Future<EnrollModel> postEnroll(Map<String, dynamic> data) async {
    try {
      var enrollRequest = enrollModelToJson(data as EnrollModel);

      dynamic response = await enrollmentService.postEnrollment(
          AppUrl.postBlogEnrollmentUrl, enrollRequest);

      if (response != null) {
        return EnrollModel.fromJson(response);
      } else {
        throw Exception('Failed to load enrollment data');
      }
    } catch (e) {
      rethrow;
    }
  }
}