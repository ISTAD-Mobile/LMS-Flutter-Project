// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:lms_mobile/model/course_details_model.dart';
//
//
// class ApiService {
//   final String baseUrl = "https://api.istad.co/shortcourse/api/v1";
//
//   Future<CourseDetailResponse> fetchCourseDetail(String uuid) async {
//     final response = await http.get(Uri.parse('$baseUrl/courses/$uuid/classes'));
//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       print('Course details: $response');
//       return CourseDetailResponse.fromJson(jsonData['data']);
//     } else {
//       throw Exception('Failed to load course details');
//     }
//   }
// }
