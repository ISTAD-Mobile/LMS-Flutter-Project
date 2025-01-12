import 'package:lms_mobile/resource/app_url.dart';
import '../../data/network/api_service.dart';
import '../../model/admission/study_program_alas.dart';

class StudyProgramAlasRepository {
  final ApiService apiService = ApiService();

  // Fetch all shifts
  Future<List<StudyProgramAlasModel>> getAllStudyProgarmAlas() async {
    try {
      final response = await apiService.getApiService(AdmissionUrl.studyProgramAlasUrl);
      return studyProgramAlasModelFromJson(response);
    } catch (exception) {
      throw Exception('Failed to fetch shifts: $exception');
    }
  }
}
