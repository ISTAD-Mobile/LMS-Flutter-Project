import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/achievement/year_of_study_achievement.dart'; // Adjust the path according to your project structure

class YearOfStudyAchievementRepository {
  final String accessToken;

  YearOfStudyAchievementRepository({required this.accessToken});

  // Function to fetch YearOfStudyAchievement data from the API
  Future<YearOfStudyAchievement> fetchYearOfStudyAchievement() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-flutter.cstad.edu.kh/api/v1/students/year-of-study-achievement'), // Replace with your actual API URL
        headers: {
          'Authorization': 'Bearer $accessToken', // Add the access token to the request header
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        return YearOfStudyAchievement.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load YearOfStudyAchievement');
      }
    } catch (e) {
      throw Exception('Failed to load YearOfStudyAchievement: $e');
    }
  }
}
