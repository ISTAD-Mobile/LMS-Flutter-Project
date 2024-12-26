import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/model/students_model/achievement_model.dart';
import 'package:lms_mobile/repository/students_repo/achievement_repo.dart';

class AchievementViewModel extends ChangeNotifier {
  final AchievementRepo achievementRepo = AchievementRepo();
  ApiResponse<AchievementModel> achievement = ApiResponse.loading();

  setAchievementBlogList(ApiResponse<AchievementModel> response){
    achievement = response;
    notifyListeners();
  }

  Future<dynamic> fetchAchievementBlogs() async {
    await achievementRepo.getAchievementBlogs()
        .then((achievement) => setAchievementBlogList(ApiResponse.completed(achievement)))
        .onError((error, stackTrace)=> ApiResponse.error(stackTrace.toString()))
    ;
  }
}

