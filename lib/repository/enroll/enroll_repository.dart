import 'dart:convert';
import '../../data/network/post_service.dart';
import '../../model/enrollmentRequest/register_model.dart';
import '../../resource/app_url.dart';

class EnrollRepository {
  var enrollService = EnrollService();

  Future<Map<String, dynamic>?> postEnrollment(EnrollmentModel data) async {
    var enrollRequest = data.toJson();
    try {
      var response = await enrollService.postEnrollment(
        AppUrl.postBlogRegisterUrl,
        enrollRequest,
      );

      if (response != null) {
        if (response is Map<String, dynamic>) {
          return response;
        }

        if (response is String) {
          try {
            var decodedResponse = json.decode(response);
            if (decodedResponse is Map<String, dynamic>) {
              return decodedResponse;
            }
          } catch (e) {
            print('Error decoding response: $e');
          }
        }
      }

      print('Error: Invalid response format or missing data');
      return null;
    } catch (error) {
      print('Error in enrollment Repository: $error');
      return null;
    }
  }
}

