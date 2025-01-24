import 'package:lms_mobile/model/admission/shift.dart';
import 'package:lms_mobile/resource/app_url.dart';
import '../../data/network/api_service.dart';

class ShiftRepository {
  final ApiService apiService = ApiService();

  // Fetch all shifts
  Future<List<ShiftModel>> getAllShifts() async {
    try {
      final response = await apiService.getApiService(AdmissionUrl.shiftUrl);
      return shiftModelFromJson(response);
    } catch (exception) {
      throw Exception('Failed to fetch shifts: $exception');
    }
  }
}
