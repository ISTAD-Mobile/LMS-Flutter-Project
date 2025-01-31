import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/student_role_model/course_detail_model.dart';

class StudentCourseDetailsRepository {
  final String baseUrl = 'https://dev-flutter.cstad.edu.kh/api';
  final String token;

  StudentCourseDetailsRepository({required this.token});

  Future<StudentCourseDetailModel> fetchStudentCourseDetail(String uuid) async {
    final url = '$baseUrl/students/course/$uuid';

    try {
      print('Fetching data from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Log the response details
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return StudentCourseDetailModel.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please check your token or log in again.');
      } else if (response.statusCode == 400) {
        throw Exception('Bad Request: Please check the UUID or request format.');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The course with this UUID does not exist.');
      } else {
        throw Exception('Failed to load course details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Something went wrong. Please try again later.');
    }
  }

}
