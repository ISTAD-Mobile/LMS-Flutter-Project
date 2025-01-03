import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/model/achievement/achievement.dart';
import '../../repository/achievement/achievement_repository.dart';

class AchievementViewModel extends ChangeNotifier {
  final AchievementRepository achievementRepository;
  final String accessToken;

  // Store API response
  ApiResponse<Achievement> achievementResponse = ApiResponse.loading();

  AchievementViewModel({
    required this.achievementRepository,
    required this.accessToken,
  });

  // Update the response and notify listeners
  void setAchievementResponse(ApiResponse<Achievement> response) {
    achievementResponse = response;
    notifyListeners();
  }

  // Fetch achievement data
  Future<void> fetchAchievement() async {
    setAchievementResponse(ApiResponse.loading()); // Set loading state
    try {
      final achievement = await achievementRepository.fetchAchievement();
      setAchievementResponse(ApiResponse.completed(achievement)); // On success
    } catch (error) {
      setAchievementResponse(ApiResponse.error(error.toString())); // On error
    }
  }
}
