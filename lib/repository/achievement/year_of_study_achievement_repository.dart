import 'dart:convert';
import "package:http/http.dart" as http;
import '../../model/achievement/year_of_study_achievement.dart';

class YearOfStudyAchievementRepository {
  final String accessToken;

  YearOfStudyAchievementRepository({required this.accessToken});

  // Fetch a list of YearOfStudyAchievement objects from the API
  Future<List<YearOfStudyAchievement>> fetchYearOfStudyAchievement() async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/year-of-study-achievements");

    try {
      var response = await http.get(
        url,
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          }
      );
      print('Request URL: ${response.request?.url}');
      print('Request Headers: ${response.request?.headers}');
      print('Response: ${response.body}');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch achievements. Status: ${response.statusCode}");
      } else {
        var jsonResponse = jsonDecode(response.body);
        // Map the JSON response to a list of YearOfStudyAchievement objects
        return (jsonResponse['content'] as List)
            .map((achievement) => YearOfStudyAchievement.fromJson(achievement))
            .toList();
      }
    } catch (e) {
      throw Exception("Error fetching achievements: $e");
    }
  }
}
