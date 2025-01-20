// import 'dart:convert';
// import "package:http/http.dart" as http;
// import '../../model/achievement/year_of_study_achievement.dart';
//
// class YearOfStudyAchievementRepository {
//   final String accessToken;
//
//   YearOfStudyAchievementRepository({required this.accessToken});

  // Fetch a list of YearOfStudyAchievement objects from the API
  // Future<List<YearOfStudyAchievement>> fetchYearOfStudyAchievement() async {
  //   Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/year-of-study-achievements");
  //
  //   try {
  //     var response = await http.get(
  //       url,
  //         headers: {
  //           'Authorization': 'Bearer $accessToken',
  //           'Content-Type': 'application/json',
  //         }
  //     );
  //     print('Request URL: ${response.request?.url}');
  //     print('Request Headers: ${response.request?.headers}');
  //     print('Response: ${response.body}');
  //     print('Status Code: ${response.statusCode}');
  //
  //     if (response.statusCode != 200) {
  //       throw Exception("Failed to fetch achievements. Status: ${response.statusCode}");
  //     } else {
  //       var jsonResponse = jsonDecode(response.body);
  //       // Map the JSON response to a list of YearOfStudyAchievement objects
  //       return (jsonResponse['content'] as List)
  //           .map((achievement) => YearOfStudyAchievement.fromJson(achievement))
  //           .toList();
  //     }
  //   } catch (e) {
  //     throw Exception("Error fetching achievements: $e");
  //   }
  // }
  // Future<List<YearOfStudyAchievement>> fetchYearOfStudyAchievement() async {
  //   Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/year-of-study-achievements");
  //
  //   try {
  //     var response = await http.get(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/json', // Confirm this is needed for GET requests
  //       },
  //     );
  //
  //     // Logging for debugging
  //     print('Request URL: ${response.request?.url}');
  //     print('Request Headers: ${response.request?.headers}');
  //     print('Response Body: ${response.body}');
  //     print('Status Code: ${response.statusCode}');
  //
  //     if (response.statusCode == 403) {
  //       throw Exception("Forbidden: Access denied. Please check your token or permissions.");
  //     } else if (response.statusCode != 200) {
  //       throw Exception("Failed to fetch achievements. Status: ${response.statusCode}");
  //     }
  //
  //     var jsonResponse = jsonDecode(response.body);
  //     return (jsonResponse['content'] as List)
  //         .map((achievement) => YearOfStudyAchievement.fromJson(achievement))
  //         .toList();
  //   } catch (e) {
  //     throw Exception("Error fetching achievements: $e");
  //   }
  // }

// import 'dart:convert';
// import "package:http/http.dart" as http;
// import '../../model/achievement/year_of_study_achievement.dart';
//
// class YearOfStudyAchievementRepository {
//   final String accessToken;
//
//   YearOfStudyAchievementRepository({required this.accessToken});
//
//   Future<List<YearOfStudyAchievement>> fetchYearOfStudyAchievement() async {
//     Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/year-of-study-achievements");
//
//     try {
//       var response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $accessToken',
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       print("API Response: $response");
//
//       if (response.statusCode != 200) {
//         throw Exception("Failed to fetch achievements. Status: ${response.statusCode}");
//       } else {
//         var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
//         return (jsonResponse['content'] as List)
//             .map((achievement) => YearOfStudyAchievement.fromJson(achievement))
//             .toList();
//       }
//     } catch (e) {
//       throw Exception("Error fetching achievements: $e");
//     }
//   }
// }



import 'package:lms_mobile/data/network/achievement_service.dart';
import 'package:lms_mobile/model/achievement/year_of_study_achievement.dart';

class YearOfStudyAchievementRepository {
  final ApiService _apiService;

  // Constructor accepting a named parameter 'accessToken'
  YearOfStudyAchievementRepository({required this.accessToken})
      : _apiService = ApiService();  // Passing 'accessToken' to ApiService

  final String accessToken;

  Future<List<Semester>> getYearOfStudyAchievements() async {
    try {
      final Map<String, dynamic> response =
      await _apiService.fetchYearOfStudyAchievements();
      return YearOfStudyAchievementResponse.fromJson(response).content;
    } catch (e) {
      throw Exception("Error in repository: $e");
    }
  }
}



