import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/model/achievement/year_of_study_achievement.dart';
import 'package:lms_mobile/repository/achievement/year_of_study_achievement_repository.dart';

class YearOfStudyAchievementViewModel extends ChangeNotifier {
  final YearOfStudyAchievementRepository _yearOfStudyAchievementRepo;

  ApiResponse<YearOfStudyAchievement> response = ApiResponse.loading();

  YearOfStudyAchievementViewModel({required YearOfStudyAchievementRepository yearOfStudyAchievementRepository})
      : _yearOfStudyAchievementRepo = yearOfStudyAchievementRepository;

  get yearOfStudyAchievementResponse => null;

  // Update the response and notify listeners
  void setYearOfStudyAchievementList(ApiResponse<YearOfStudyAchievement> response) {
    this.response = response;
    notifyListeners();
  }

  // Fetch year of study achievement data
  Future<void> getYearOfStudyAchievement() async {
    setYearOfStudyAchievementList(ApiResponse.loading()); // Set loading state
    try {
      final yearOfStudyAchievement = await _yearOfStudyAchievementRepo.fetchYearOfStudyAchievement();
      setYearOfStudyAchievementList(ApiResponse.completed(yearOfStudyAchievement)); // On success
    } catch (error) {
      setYearOfStudyAchievementList(ApiResponse.error(error.toString())); // On error
    }
  }
}
