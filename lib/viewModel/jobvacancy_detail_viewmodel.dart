import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/jobvacancy_detial_repository.dart';
import 'dart:io';

import '../model/jobvacancy_detail.dart';

class JobvacancyDetailViewmodel extends ChangeNotifier {
  final JobvacancyDetialRepository _repositoryJobvacancy = JobvacancyDetialRepository();
  JobvacancyDetailModel? jobvacancyDetail;
  bool isLoading = false;
  String? errorMessage;

  Future<void> getJobvacancyDetail(int id) async {
    try {
      // Start loading
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      // Fetch data
      final response = await _repositoryJobvacancy.fetchJobvacancyDetail(id);

      if (response == null || response.data == null) {
        errorMessage = "No data available.";
      } else {
        jobvacancyDetail = response;
      }

    } on SocketException {
      errorMessage = "No internet connection. Please check your network and try again.";
    } on HttpException {
      errorMessage = "Couldn't retrieve data. Please try again later.";
    } on FormatException {
      errorMessage = "Bad response format. Please contact support.";
    } catch (e) {
      errorMessage = "Something went wrong. Please try again later.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
