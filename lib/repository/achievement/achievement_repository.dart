import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/achievement/achievement.dart';

class AchievementRepository {
  final String accessToken;

  AchievementRepository({required this.accessToken});

  // Function to fetch achievement data from the API
  Future<Achievement> fetchAchievement() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-flutter.cstad.edu.kh/api/v1/students/achievement'),
        headers: {
          'Authorization': 'Bearer $accessToken',  // Add the access token to the request header
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        return Achievement.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load achievement');
      }
    } catch (e) {
      throw Exception('Failed to load achievement: $e');
    }
  }
}
