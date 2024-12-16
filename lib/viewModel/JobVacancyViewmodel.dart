import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/model/jobvacancy.dart';
import 'package:lms_mobile/repository/jobvacancy_repository.dart';


class JobvacancyViewModel extends ChangeNotifier {
  final JobvacancyRepository jobvacancyRepository = JobvacancyRepository();
  ApiResponse<JobVacancyResponse> jobvacancy = ApiResponse.loading();

  setBlogList(ApiResponse<JobVacancyResponse> response){
    jobvacancy = response;
    notifyListeners();
  }

  Future<dynamic> fetchAllJobvacancy() async {
    await jobvacancyRepository.getAllJobvacancy()
        .then((jobvacancy) => setBlogList(ApiResponse.completed(jobvacancy)))
        .onError((error, stackTrace)=> ApiResponse.error(stackTrace.toString()))
    ;
  }
}



