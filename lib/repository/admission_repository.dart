

import 'package:lms_mobile/data/network/api_service.dart';
import 'package:lms_mobile/model/request/admission.dart';
import 'package:lms_mobile/resource/app_url.dart';

class AdmissionRepository {

  var apiService = ApiService();

  Future<dynamic> postAdmission (data) async {
    var admissionRequest = admissionToJson(data);
    dynamic response = await apiService.postAdmission(AdmissionUrl.postAdmisionByUrl,admissionRequest);
  }
}
