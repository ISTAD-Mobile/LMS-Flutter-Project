import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/student_role_model/course_detail_model.dart';

class CourseService {
  static const String baseUrl = "https://dev-flutter.cstad.edu.kh/api/v1";

  Future<StudentCourseDetailModel> fetchCourseDetail(String uuid) async {
    final response = await http.get(Uri.parse('$baseUrl/students/course/$uuid'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return StudentCourseDetailModel.fromJson(data);
    } else {
      throw Exception('Failed to load course detail');
    }
  }
}
