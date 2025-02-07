import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/student_role_model/course_detail_model.dart';

class StudentCourseDetailsRepository {
  final String token;

  StudentCourseDetailsRepository({required this.token});

  Future<StudentCourseDetailModel> fetchStudentCourseDetails(String courseUuid) async {
    final url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/course/$courseUuid");
    print("Url : $url");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
      );
      print('Token: ${token}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return StudentCourseDetailModel.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Token might be expired or invalid.');
      } else {
        throw Exception('Failed to load course details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}

