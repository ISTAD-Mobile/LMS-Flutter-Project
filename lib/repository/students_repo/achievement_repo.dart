// import 'package:lms_mobile/data/network/achievement_service/achievement.dart';
// import 'package:lms_mobile/model/students_model/achievement_model.dart';
// import 'package:lms_mobile/resource/app_url.dart';
//
// class AchievementRepo {
//   final AchievementApiService achievementApiService = AchievementApiService();
//
//   Future<AchievementModel> getAchievementBlogs() async {
//     try {
//       final achievementData = await achievementApiService
//           .getAchievementApiService(ApiUrl.achievementUrl);
//       print("Achievement URL: ${ApiUrl.achievementUrl}");
//       return achievementModelFromJson(achievementData);
//     } catch (exception) {
//       rethrow;
//     }
//   }
// }


import 'package:lms_mobile/data/network/achievement_service/achievement.dart';
import 'package:lms_mobile/model/students_model/achievement_model.dart';
import 'package:lms_mobile/resource/app_url.dart';

class AchievementRepo {
  final AchievementApiService achievementApiService = AchievementApiService();

  Future<AchievementModel> getAchievementBlogs() async {
    try {
      final achievementData = await achievementApiService
          .getAchievementApiService(ApiUrl.achievementUrl);
      print("Achievement URL: ${ApiUrl.achievementUrl}");
      return achievementModelFromJson(achievementData);
    } catch (exception) {
      print("Error fetching achievements: $exception");
      rethrow;
    }
  }
}