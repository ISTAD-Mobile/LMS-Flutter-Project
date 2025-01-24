import '../../data/network/api_service.dart';
import '../../model/enrollment_response/place_of_birth.dart';
import '../../resource/app_url.dart';

class PlaceOfBirthRepo {
  final ApiService apiService = ApiService();

  Future<PlaceOfBirthModel> getAllBlogs() async {
    try {
      final response = await apiService.getApiService(AppUrl.getPlaceOfBirthUrl);
      return placeOfBirthModelFromJson(response);
    } catch (exception) {
      throw Exception('Failed to fetch place of birth data: $exception');
    }
  }
}