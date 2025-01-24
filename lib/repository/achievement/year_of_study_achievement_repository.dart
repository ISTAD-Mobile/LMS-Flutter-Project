import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/achievement/year_of_study_achievement.dart';

class YearOfStudyAchievementRepository {
  final String accessToken;

  YearOfStudyAchievementRepository({required this.accessToken});

  Future<List<YearOfStudyAchievement>> fetchAchievements() async {
    final response = await http.get(
      Uri.parse('https://dev-flutter.cstad.edu.kh/api/v1/students/year-of-study-achievement'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final responseModel = Response.fromJson(responseData);
      return responseModel.content;
    } else {
      throw Exception('Failed to load achievements');
    }
  }
}
