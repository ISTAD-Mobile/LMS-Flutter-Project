import 'package:lms_mobile/data/network/api_service.dart';
import 'package:lms_mobile/model/jobvacancy.dart';
import 'package:lms_mobile/resource/app_url.dart';

class JobvacancyRepository{
  final ApiService apiService = ApiService();

  Future<JobvacancyResponse> getAllJobvacancy() async {
    try{
      final jobvacancyData = await apiService.getApiService(JobVocancyUrl.getJobvacancyByUrl);
      print("Job Vacancy Data: $jobvacancyData");
      return jobvacancyResponseFromJson(jobvacancyData);
    }catch (exception) {
      rethrow;
    }
  }
}