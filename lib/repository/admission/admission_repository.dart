import 'dart:convert';
import 'package:lms_mobile/model/admission/admission_form.dart';
import 'package:lms_mobile/resource/app_url.dart';
import '../../data/network/admission_service.dart';

class AdmissionRepository {
  var admissionService = AdmissionService();

  Future<Map<String, dynamic>?> postAdmission(AdmissionRequest data) async {
    var admissionRequest = data.toJson();
    print('Request data: $admissionRequest');

    try {
      var response = await admissionService.postAdmission(
        AdmissionUrl.postAdmisionByUrl,
        admissionRequest,
      );

      print('Raw API Response: $response');

      if (response != null) {
        if (response is Map<String, dynamic>) {
          print('Response is already a Map: $response');
          return response;
        }

        if (response is String) {
          try {
            var decodedResponse = json.decode(response);
            print('Decoded API Response: $decodedResponse');
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
      print('Error in AdmissionRepository: $error');
      return null;
    }
  }
}

