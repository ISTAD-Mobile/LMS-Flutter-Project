// import 'package:flutter/material.dart';
// import 'package:lms_mobile/data/response/api_response.dart';
// import 'package:lms_mobile/model/jobvacancy.dart';
// import 'package:lms_mobile/repository/jobvacancy_repository.dart';
//
//
// class JobvacancyViewModel extends ChangeNotifier {
//   final JobvacancyRepository jobvacancyRepository = JobvacancyRepository();
//   ApiResponse<JobVacancyResponse> jobvacancy = ApiResponse.loading();
//
//   setBlogList(ApiResponse<JobVacancyResponse> response){
//     jobvacancy = response;
//     notifyListeners();
//   }
//
//   Future<dynamic> fetchAllJobvacancy() async {
//     await jobvacancyRepository.getAllJobvacancy()
//         .then((course) => setBlogList(ApiResponse.completed(course)))
//         .onError((error, stackTrace)=> ApiResponse.error(stackTrace.toString()))
//     ;
//   }
// }
//


import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/model/jobvacancy.dart';
import 'package:lms_mobile/repository/jobvacancy_repository.dart';

class JobvacancyViewModel {
  final JobvacancyRepository jobvacancyRepository = JobvacancyRepository();
  ApiResponse<JobVacancyResponse> jobvacancy = ApiResponse.loading();

  setJobVacancy(ApiResponse<JobVacancyResponse> response) {
    jobvacancy = response;
  }

  Future<void> fetchAllJobvacancy() async {
    try {
      final jobVacancyData = await jobvacancyRepository.getAllJobvacancy();
      setJobVacancy(ApiResponse.completed(jobVacancyData));
    } catch (e) {
      setJobVacancy(ApiResponse.error(e.toString()));
    }
  }
}

