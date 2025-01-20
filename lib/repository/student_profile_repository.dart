import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_mobile/model/student_profile_model.dart';

class StudentProfileRepository {
  final String token;

  StudentProfileRepository({required this.token});

  // Fetch user data from the API
  Future<StudentProfileModel> fetchUserData() async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/achievement");

    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return StudentProfileModel.fromJson(jsonResponse); // Convert JSON to User object
      } else {
        throw Exception("Failed to fetch user data");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}
