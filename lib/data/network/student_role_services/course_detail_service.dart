// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class StudentCoursesDetailsService {
//   final String baseUrl = 'https://dev-flutter.cstad.edu.kh/api/v1';
//   final String token;
//   StudentCoursesDetailsService({required this.token});
//
//   Future<Map<String, dynamic>> fetchStudentCoursesDetails(String uuid) async {
//     final url = Uri.parse('$baseUrl/students/course/$uuid');
//     print("Course url : $url");
//     try {
//       final response = await http.get(url, headers: {
//         "Authorization": "Bearer $token",
//       });
//
//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         print('Error response body: ${response.body}');
//         throw Exception(
//             'Failed to fetch student courses: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error occurred while fetching data: $e');
//       throw Exception('Failed to fetch student courses: $e');
//     }
//   }
// }
