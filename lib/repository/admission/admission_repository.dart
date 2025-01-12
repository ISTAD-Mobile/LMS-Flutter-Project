import 'package:lms_mobile/model/admission/admission_form.dart';
import 'package:lms_mobile/resource/app_url.dart';
import '../../data/network/admission_service.dart';


class AdmissionRepository {

  var admissionService = AdmissionService();

  Future<bool> postAdmission(data) async {
    var admissionRequest = admissionRequestToJson(data);
    print(admissionRequest);
    dynamic response = await admissionService.postAdmission(AdmissionUrl.postAdmisionByUrl,admissionRequest);
    return response;
  }
}
