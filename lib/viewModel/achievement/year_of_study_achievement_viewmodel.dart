// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:lms_mobile/model/achievement/year_of_study_achievement.dart';
//
//
// class YearOfStudyAchievementViewModel extends ChangeNotifier {
//   YearOfStudyAchievement? yearOfStudyAchievement;
//   bool isLoading = false;
//   String? errorMessage;
//
//   Future<void> fetchYearOfStudyData(String accessToken) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await http.get(
//         Uri.parse('https://your-api-endpoint.com/api/achievements'),
//         headers: {'Authorization': 'Bearer $accessToken'},
//       );
//
//       if (response.statusCode == 200) {
//         yearOfStudyAchievement = yearOfStudyAchievementFromJson(response.body);
//       } else {
//         errorMessage = "Failed to fetch data: ${response.statusCode}";
//       }
//     } catch (e) {
//       errorMessage = "An error occurred: $e";
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // Utility methods for getting data (e.g., total courses, GPA, etc.)
//   String getYearSemester(int index) {
//     final content = yearOfStudyAchievement?.content[index];
//     return "Year ${content?.year} - Semester ${content?.semester}";
//   }
//
//   int getTotalCourses(int index) {
//     return yearOfStudyAchievement?.content[index].course.length ?? 0;
//   }
//
//   int? getTotalCredits(int index) {
//     return yearOfStudyAchievement?.content[index].course.fold(0, (sum, course) => sum! + course.credit);
//   }
//
//   double getGPA(int index) {
//     final courses = yearOfStudyAchievement?.content[index].course ?? [];
//     if (courses.isEmpty) return 0.0;
//
//     final totalScore = courses.fold(0, (sum, course) => sum + course.score);
//     return totalScore / courses.length;
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:lms_mobile/model/achievement/year_of_study_achievement.dart';
// import 'package:lms_mobile/model/student_profile_model.dart';
// import 'package:lms_mobile/repository/student_profile_repository.dart';
//
//
//
// class YearOfStudyAchievementViewmodel extends ChangeNotifier {
//   final StudentProfileRepository userRepository;
//   StudentProfileModel? _user;
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   YearOfStudyAchievementViewmodel({required this.userRepository});
//
//   StudentProfileModel? get user => _user;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//
//   // Fetch user data
//   Future<void> fetchUserData() async {
//     _setLoading(true);
//
//     try {
//       _user = await userRepository.fetchUserData();
//       _errorMessage = null;
//     } catch (e) {
//       _errorMessage = "Error: $e";
//     }
//
//     _setLoading(false);
//   }
//
//   void _setLoading(bool value) {
//     _isLoading = value;
//     Future.microtask(() => notifyListeners());
//   }
// }

import 'package:flutter/material.dart';
import 'package:lms_mobile/model/achievement/year_of_study_achievement.dart';
import 'package:lms_mobile/repository/achievement/year_of_study_achievement_repository.dart';

class YearOfStudyAchievementViewmodel extends ChangeNotifier {
  final YearOfStudyAchievementRepository userRepository;
  List<YearOfStudyAchievement>? _achievements;
  bool _isLoading = false;
  String? _errorMessage;

  YearOfStudyAchievementViewmodel({required this.userRepository});

  List<YearOfStudyAchievement>? get achievements => _achievements;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch year of study achievements
  Future<void> fetchAchievements() async {
    _setLoading(true);

    try {
      _achievements = (await userRepository.fetchYearOfStudyAchievement()) as List<YearOfStudyAchievement>?;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }
}
