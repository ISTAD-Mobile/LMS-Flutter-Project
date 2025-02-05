
import '../data/network/jobvacancy_service.dart';
import '../model/jobvacancy.dart';
import '../resource/app_url.dart';

class JobVacancyRepository {
  final JobvacancyService jobvacancyService = JobvacancyService();

  Future<JobvacancyResponse> getAllJobVacancies() async {
    try {
      final jobVacancyData = await jobvacancyService.getApiJobvacancy(JobVocancyUrl.getJobvacancyByUrl);
      return jobvacancyResponseFromJson(jobVacancyData);
    } catch (exception) {
      print("Error in JobVacancyRepository: $exception");
      rethrow;
    }
  }
}
