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
    return jobVacancy.data?.dataList
        .map((job) => job.title)
        .toList() ??
        [];
  }

  /// Get job vacancy data list
  List<JobvacancyDataList> get jobVacancyDataList {
    return jobVacancy.data?.dataList ?? [];
  }
}


// import 'package:flutter/material.dart';
// import 'package:lms_mobile/model/jobvacancy.dart';
// import 'package:lms_mobile/repository/jobvacancy_repository.dart';
// import '../data/response/api_response.dart';
//
// class JobvacancyViewModel extends ChangeNotifier {
//   final JobVacancyRepository _jobVacancyRepository;
//
//   // Initial API response with a loading state
//   ApiResponse<JobvacancyResponse> jobVacancy = ApiResponse.loading();
//
//   // Constructor with dependency injection for testability
//   JobvacancyViewModel({JobVacancyRepository? repository})
//       : _jobVacancyRepository = repository ?? JobVacancyRepository();
//
//   /// Updates the job vacancy state and notifies listeners
//   void _setJobVacancy(ApiResponse<JobvacancyResponse> response) {
//     jobVacancy = response;
//     notifyListeners();
//   }
//
//   /// Fetch all job vacancies
//   Future<void> fetchAllJobVacancy() async {
//     _setJobVacancy(ApiResponse.loading());
//     try {
//       final response = await _jobVacancyRepository.getAllJobVacancies();
//       _setJobVacancy(ApiResponse.completed(response));
//     } catch (error) {
//       _setJobVacancy(ApiResponse.error(error.toString()));
//     }
//   }
//
//   /// Get list of job vacancy titles
//   List<String> get jobVacancyTitles {
//     return jobVacancy.data?.dataList.map((job) => job.title).toList() ?? [];
//   }
//
//   /// Get list of job vacancy data
//   List<JobvacancyDataList> get jobVacancyDataList {
//     return jobVacancy.data?.dataList ?? [];
//   }
// }
