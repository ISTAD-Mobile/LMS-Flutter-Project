import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/achievement/year_of_study_achievement.dart';

class YearOfStudyAchievementRepository {
  final String accessToken;

  YearOfStudyAchievementRepository({required this.accessToken});

  // Function to fetch YearOfStudyAchievement data from the API
  Future<YearOfStudyAchievement> fetchYearOfStudyAchievement() async {
    final url =
        'https://dev-flutter.cstad.edu.kh/api/v1/students/year-of-study-achievement'; // Replace with your actual API URL
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken', // Add the access token to the request header
          'Content-Type': 'application/json', // Ensure proper content type
        },
      );

      if (response.statusCode == 200) {
        // Parse and return the JSON response
        return YearOfStudyAchievement.fromJson(json.decode(response.body));
      } else {
        // Throw an exception with detailed error info
        throw Exception(
          'Failed to load YearOfStudyAchievement. Status Code: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load YearOfStudyAchievement: $e');
    }
  }
}
