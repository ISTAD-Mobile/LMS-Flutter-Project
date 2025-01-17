import 'package:flutter/material.dart';
import 'package:lms_mobile/model/jobvacancy.dart';
import 'package:lms_mobile/repository/jobvacancy_repository.dart';
import '../data/response/api_response.dart';

class JobvacancyViewModel extends ChangeNotifier {
  final JobVacancyRepository _jobVacancyRepository = JobVacancyRepository();

  ApiResponse<JobvacancyResponse> jobVacancy = ApiResponse.loading();

  void setJobVacancy(ApiResponse<JobvacancyResponse> response) {
    jobVacancy = response;
    print('Jobvacancy view model : ${response}');
    notifyListeners();
  }

  /// Fetch all job vacancies
  Future<void> fetchAllJobvacancy() async {
    setJobVacancy(ApiResponse.loading());

    try {
      final response = await _jobVacancyRepository.getAllJobVacancies();
      setJobVacancy(ApiResponse.completed(response));
    } catch (error) {
      setJobVacancy(ApiResponse.error(error.toString()));
    }
  }

  /// Get job vacancy titles
  List<String> get jobVacancyTitles {
    return jobVacancy.data?.data
        .map((job) => job.title)
        .toList() ??
        [];
  }

  /// Get job vacancy data list
  List<JobvacancyDataList> get jobVacancyDataList {
    return jobVacancy.data?.data ?? [];
  }
}
