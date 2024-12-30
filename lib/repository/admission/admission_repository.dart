import 'package:lms_mobile/data/network/api_service.dart';
import 'package:lms_mobile/model/admission/admission_form.dart';
import 'package:lms_mobile/resource/app_url.dart';


class AdmissionRepository {

  var apiService = ApiService();

  Future<bool> postAdmission(data) async {
    var admissionRequest = admissionRequestToJson(data);
    print('posting ...');
    dynamic response = await apiService.postAdmission(AdmissionUrl.postAdmisionByUrl,admissionRequest);
    return response;
  }
}
