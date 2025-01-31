import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://dev-flutter.cstad.edu.kh/api/v1";

  Future<Map<String, dynamic>> fetchYearOfStudyAchievements() async {
    final url = Uri.parse("$baseUrl/students/year-of-study-achievement");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to load achievements");
    }
  }
}
