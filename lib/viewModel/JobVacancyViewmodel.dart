import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/model/jobvacancy.dart';
import 'package:lms_mobile/repository/jobvacancy_repository.dart';


class JobvacancyViewModel extends ChangeNotifier {
  final JobvacancyRepository jobvacancyRepository = JobvacancyRepository();
  ApiResponse<JobvacancyResponse> jobvacancy = ApiResponse.loading();

  setJobvacancyList(ApiResponse<JobvacancyResponse> response) {
    jobvacancy = response;
    notifyListeners();
  }

  Future<dynamic> getAllJobvacancy() async {
    await jobvacancyRepository.getAllJobvacancy()
        .then((jobvacancy) => setJobvacancyList(ApiResponse.completed(jobvacancy)))
        .onError((error, stackTrace)=> ApiResponse.error(stackTrace.toString()))
    ;
  }
}




