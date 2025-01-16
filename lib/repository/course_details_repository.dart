import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/course_details_model.dart';

class CourseDetailsRepository {
  final String baseUrl = 'https://api.istad.co/shortcourse/api/v1';

  Future<CourseDetailResponse> fetchCourseDetail(String uuid) async {
    final url = '$baseUrl/courses/$uuid/classes';

    try {
      // Log the API URL for debugging
      print('Fetching data from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Log the response details
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return CourseDetailResponse.fromJson(jsonData);
      } else {
        // Handle different status codes for better error feedback
        if (response.statusCode == 400) {
          throw Exception('Bad Request: Please check the UUID or request format.');
        } else if (response.statusCode == 404) {
          throw Exception('Not Found: The course with this UUID does not exist.');
        } else {
          throw Exception('Failed to load course details. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Something went wrong. Please try again later.');
    }
  }
}
