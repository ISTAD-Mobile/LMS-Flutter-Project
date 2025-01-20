import 'package:flutter/material.dart';
import 'package:lms_mobile/model/achievement/year_of_study_achievement.dart';
import 'package:lms_mobile/repository/achievement/year_of_study_achievement_repository.dart';
import '../../data/response/api_response.dart';

class YearOfStudyAchievementViewmodel extends ChangeNotifier {
  final YearOfStudyAchievementRepository _yearOfStudyAchievementRepository =
  YearOfStudyAchievementRepository(accessToken: '');

  ApiResponse<YearOfStudyAchievementModel> yearOfStudy = ApiResponse.loading();

  // Method to update yearOfStudy state
  void setYearOfStudy(ApiResponse<YearOfStudyAchievementModel> response) {
    yearOfStudy = response;
    print('YearOfStudyAchievementViewModel updated: $response');
    notifyListeners();
  }

  /// Fetch Year of Study achievements
  Future<void> fetchAllYearOfStudy() async {
    setYearOfStudy(ApiResponse.loading());

    try {
      final response = await _yearOfStudyAchievementRepository.fetchYearOfStudyData();
      setYearOfStudy(ApiResponse.completed(response));
    } catch (error) {
      setYearOfStudy(ApiResponse.error(error.toString()));
    }
  }

  /// Get the list of achievements
  List<YearOfStudyList> get yearOfStudyList {
    // Access the 'yearOfStudy' data safely
    return yearOfStudy.data?.yearOfStudy ?? [];
  }

  /// Get titles of courses for display (example method, can be customized)
  List<String> get yearOfStudyCourseTitles {
    // Collect all course titles from the data if available
    List<String> titles = [];
    if (yearOfStudy.data != null) {
      for (var yearOfStudyItem in yearOfStudy.data!.yearOfStudy) {
        for (var course in yearOfStudyItem.courseList) {
          titles.add(course.title);
        }
      }
    }
    return titles;
  }
}
