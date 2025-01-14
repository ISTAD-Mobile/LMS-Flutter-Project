import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentCoursesService {
  final String baseUrl = 'https://dev-flutter.cstad.edu.kh/api/v1';
  final String accessToken;

  StudentCoursesService({required this.accessToken});

  Future<Map<String, dynamic>> fetchStudentCourses() async {
    final url = Uri.parse('$baseUrl/students/courses');
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error response body: ${response.body}');
        throw Exception(
            'Failed to fetch student courses: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching data: $e');
      throw Exception('Failed to fetch student courses: $e');
    }
  }
}
