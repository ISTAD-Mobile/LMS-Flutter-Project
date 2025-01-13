import '../../data/network/enrollment_service.dart';
import '../../model/enrollmentRequest/register_model.dart';
import '../../resource/app_url.dart';

class EnrollRepository {
  var enrollmentService = EnrollmentService();

  Future<EnrollmentModel> postEnrollment(Map<String, dynamic> data) async {
    try {
      // Convert the data to JSON
      var enrollmentRequest = enrollmentModelToJson(data as EnrollmentModel);

      // Make the API call
      dynamic response = await enrollmentService.postEnrollment(
          AppUrl.postBlogRegisterUrl, enrollmentRequest);

      // Check if the response is successful, then parse the data into EnrollmentModel
      if (response != null) {
        return EnrollmentModel.fromJson(response);
      } else {
        throw Exception('Failed to load enrollment data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
