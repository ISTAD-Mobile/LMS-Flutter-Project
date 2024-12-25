import 'package:lms_mobile/model/enrollment_response/current_address.dart';

import '../../data/network/api_service.dart';
import '../../resource/app_url.dart';

class CurrentAddressRepo {
  final ApiService apiService = ApiService();

  Future<CurrentAddressModel> getAllBlogs() async {
    try {
      final response = await apiService.getApiService(AppUrl.getCurrentAddressUrl);
      return currentAddressModelFromJson(response);
    } catch (exception) {
      throw Exception('Failed to fetch current address: $exception');
    }
  }
}