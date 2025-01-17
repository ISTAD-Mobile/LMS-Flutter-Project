import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/student_profile_setting.dart';

class UpdateStudentProfileSettingRepository {
  final String accessToken;

  UpdateStudentProfileSettingRepository({required this.accessToken});

  Future<StudentSettingModel> fetchUdateData() async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/setting");

    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      print('Access Token Update data : ${accessToken}');

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

  Future<bool> updateStudentProfileSetting(StudentSettingModel studentSetting) async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/setting");

    try {
      final response = await http.patch(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
        body: jsonEncode(studentSetting.toJson()),
      );

      print('Access Token Update data : ${accessToken}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to update student profile: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error updating student profile: $e");
    }
  }
}

