
import 'package:lms_mobile/data/network/api_service.dart';
import 'package:lms_mobile/resource/app_url.dart';

import '../../model/enrollmentRequest/enrollment_model.dart';

class EnrollRepository {
  var apiService = ApiService();

  Future<dynamic> postEnrollment(data) async {
    var enrollmentRequest = enrollmentModelToJson(data);
    dynamic response = await apiService.postEnrollment(AppUrl.postBlogUrl, enrollmentRequest);
    }
}
