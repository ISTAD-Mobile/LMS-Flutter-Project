// // import 'package:flutter/material.dart';
// // import 'package:lms_mobile/repository/achievement/year_of_study_achievement_repository.dart';
// // import '../../model/achievement/year_of_study_achievement.dart';
// //
// // class YearOfStudyAchievementViewmodel extends ChangeNotifier {
// //   final YearOfStudyAchievementRepository userRepository;
// //   List<YearOfStudyAchievement>? _achievements;
// //   bool _isLoading = false;
// //   String? _errorMessage;
// //
// //   YearOfStudyAchievementViewmodel({required this.userRepository});
// //
// //   List<YearOfStudyAchievement>? get achievements => _achievements;
// //   bool get isLoading => _isLoading;
// //   String? get errorMessage => _errorMessage;
// //
// //   Future<void> fetchAchievements() async {
// //     _setLoading(true);
// //
// //     try {
// //       _achievements = await userRepository.fetchYearOfStudyAchievement();
// //       _errorMessage = null;
// //     } catch (e) {
// //       _errorMessage = "Error: $e";
// //     }
// //
// //     _setLoading(false);
// //   }
// //
// //   void _setLoading(bool value) {
// //     _isLoading = value;
// //     Future.microtask(() => notifyListeners());
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'dart:convert';  // To decode the JSON response
// import 'package:lms_mobile/repository/achievement/year_of_study_achievement_repository.dart';
// import '../../model/achievement/year_of_study_achievement.dart';
//
// class YearOfStudyAchievementViewmodel extends ChangeNotifier {
//   final YearOfStudyAchievementRepository userRepository;
//   List<Content>? _content;  // List of Content
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   YearOfStudyAchievementViewmodel({required this.userRepository});
//
//   List<Content>? get content => _content;  // Getter for content
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//
//   Future<void> fetchAchievements() async {
//     _setLoading(true);
//
//     try {
//       // Fetching achievements from the repository (This should return a String containing JSON)
//       final response = await userRepository.fetchYearOfStudyAchievement();
//
//       // Check if the response is empty or null
//       if (response == null || response.isEmpty) {
//         _errorMessage = "No achievements data found.";
//       } else {
//         // Parse the JSON response into YearOfStudyAchievement object
//         final yearOfStudyAchievement = yearOfStudyAchievementFromJson(response as String);
//
//         // Check if content is empty
//         if (yearOfStudyAchievement.content == null || yearOfStudyAchievement.content!.isEmpty) {
//           _errorMessage = "No achievements found.";
//         } else {
//           _content = yearOfStudyAchievement.content;  // Assigning content directly
//           _errorMessage = null;  // Clear error message on successful data fetch
//         }
//       }
//     } catch (e) {
//       _errorMessage = "Error: $e";
//       print('Error fetching achievements: $e'); // Debugging error message
//     }
//
//     _setLoading(false);
//   }
//
//   // Helper function to parse the JSON response (String) into YearOfStudyAchievement object
//   YearOfStudyAchievement yearOfStudyAchievementFromJson(String str) {
//     final jsonData = json.decode(str);  // Decode the String to Map
//     return YearOfStudyAchievement.fromJson(jsonData);  // Parse the Map into the model
//   }
//
//   void _setLoading(bool value) {
//     _isLoading = value;
//     Future.microtask(() => notifyListeners());
//   }
// }





import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/achievement/year_of_study_achievement_repository.dart';
import '../../model/achievement/year_of_study_achievement.dart';

class YearOfStudyAchievementViewmodel extends ChangeNotifier {
  final YearOfStudyAchievementRepository _repository = YearOfStudyAchievementRepository();
  YearOfStudyAchievementModel? _achievementData;
  bool _isLoading = false;
  String? _errorMessage;

  YearOfStudyAchievementModel? get achievementData => _achievementData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Content>? get content => _achievementData?.content;

  Future<void> fetchYearOfStudyAchievement() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _achievementData = await _repository.getYearOfStudyAchievement();
      print('Achievement data fetched: ${_achievementData.toString()}');
    } catch (e) {
      _errorMessage = e.toString();
      print('Error fetching data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}

