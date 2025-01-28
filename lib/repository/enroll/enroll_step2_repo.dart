import 'dart:convert';
import 'package:lms_mobile/data/network/post_service.dart';
import '../../model/enrollmentRequest/enroll.dart';
import '../../resource/app_url.dart';

class EnrollStep2Repo {
  var enrollStep2 = EnrollStep2Service();

  Future<Map<String, dynamic>?> postEnrollmentStep2(EnrollmentModelStep2 data) async {
    var enrollRequest = data.toJson();
    try {
      var response = await enrollStep2.postEnrollmentStep2(
        AppUrl.postBlogEnrollmentUrl,
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

