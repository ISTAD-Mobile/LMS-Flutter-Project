
import 'package:lms_mobile/model/admission/degree.dart';
import 'package:lms_mobile/resource/app_url.dart';

import '../../data/network/api_service.dart';

class DegreeRepository {
  final ApiService apiService = ApiService();

  // Fetch all shifts
  Future<List<DegreeModel>> getAllDegree() async {
    try {
      final response = await apiService.getApiService(AdmissionUrl.degreeUrl);
      return degreeModelFromJson(response);
    } catch (exception) {
      throw Exception('Failed to fetch shifts: $exception');
    }
  }
}
