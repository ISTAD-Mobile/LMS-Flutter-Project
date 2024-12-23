import 'package:lms_mobile/model/enrollment_response/current_address.dart';
import 'package:lms_mobile/model/enrollment_response/university.dart';

import '../../data/network/api_service.dart';
import '../../resource/app_url.dart';

class UniversityRepo {
  final ApiService apiService = ApiService();

  Future<UniversitiesModel> getAllBlogs() async {
    try {
      final response = await apiService.getApiService(AppUrl.getUniversityUrl);
      return universitiesModelFromJson(response);
    } catch (exception) {
      throw Exception('Failed to fetch university: $exception');
    }
  }
}