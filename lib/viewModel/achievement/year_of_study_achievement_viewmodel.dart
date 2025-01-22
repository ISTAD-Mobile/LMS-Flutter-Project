
import 'package:lms_mobile/repository/achievement/year_of_study_achievement_repository.dart';

import '../../model/achievement/year_of_study_achievement.dart';

class YearOfStudyAchievementViewModel {
  final YearOfStudyAchievementRepository repository;

  YearOfStudyAchievementViewModel({required this.repository});

  Future<List<YearOfStudyAchievement>> fetchAchievements() {
    return repository.fetchAchievements();
  }
}
