import '../data/network/jobvacancy-service.dart';
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


// import '../data/network/jobvacancy-service.dart';
// import '../model/jobvacancy.dart';
// import '../resource/app_url.dart';
//
// class JobVacancyRepository {
//   final JobvacancyService jobvacancyService;
//
//   // Constructor injection for better testability
//   JobVacancyRepository({JobvacancyService? service})
//       : jobvacancyService = service ?? JobvacancyService();
//
//   Future<JobvacancyResponse> getAllJobVacancies() async {
//     try {
//       // Fetch data from the service
//       final jobVacancyData = await jobvacancyService.getApiJobvacancy(
//         JobVocancyUrl.getJobvacancyByUrl,
//       );
//
//       // Debug log to verify fetched data
//       print("Job Vacancy Repo: $jobVacancyData");
//
//       // Parse JSON response into JobvacancyResponse object
//       return jobvacancyResponseFromJson(jobVacancyData);
//     } catch (exception) {
//       // Log and rethrow the exception for the caller to handle
//       print("Error in JobVacancyRepository: $exception");
//       rethrow;
//     }
//   }
// }
