import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/model/achievement/achievement.dart';
import '../../repository/achievement/achievement_repository.dart';


class AchievementViewModel extends ChangeNotifier {
  final AchievementRepository _achievementRepo;

  ApiResponse<Achievement> response = ApiResponse.loading();

  AchievementViewModel({required AchievementRepository achievementRepository, required String accessToken})
      : _achievementRepo = achievementRepository;

  get achievementResponse => null;

  // Update the response and notify listeners
  void setAchievementList(ApiResponse<Achievement> response) {
    this.response = response;
    notifyListeners();
  }

  // Fetch achievement data
  Future<void> getAchievement() async {
    setAchievementList(ApiResponse.loading()); // Set loading state
    try {
      final achievement = await _achievementRepo.fetchAchievement();
      setAchievementList(ApiResponse.completed(achievement)); // On success
    } catch (error) {
      setAchievementList(ApiResponse.error(error.toString())); // On error
    }
  }
}
