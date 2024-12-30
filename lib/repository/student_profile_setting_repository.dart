import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_mobile/model/student_profile_setting.dart';

class StudentProfileSettingRepository {
  final String accessToken;

  StudentProfileSettingRepository({required this.accessToken});

  // Fetch user data from the API
  Future<StudentProfileSettingModel> fetchUserData() async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/setting");

    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return StudentProfileSettingModel.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to fetch user data");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}
