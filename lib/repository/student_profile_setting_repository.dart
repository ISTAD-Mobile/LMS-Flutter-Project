import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/student_profile_setting.dart';

class StudentSettingRepository {
  final String accessToken;

  StudentSettingRepository({required this.accessToken});

  Future<StudentSettingModel> fetchUserData() async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/setting");

    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);
        return StudentSettingModel.fromJson(userData);
      } else {
        throw Exception("Failed to fetch user data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}

