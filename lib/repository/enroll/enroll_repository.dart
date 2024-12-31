import '../../data/network/enrollment_service.dart';
import '../../model/enrollmentRequest/enrollment_model.dart';
import '../../resource/app_url.dart';


class EnrollRepository {
  var enrollmentService = EnrollmentService();

  Future<dynamic> postEnrollment(data) async {
    var enrollmentRequest = enrollmentModelToJson(data);
    dynamic enrollment = await enrollmentService.postEnrollment(AppUrl.postBlogRegisterUrl, enrollmentRequest);
    }
}
