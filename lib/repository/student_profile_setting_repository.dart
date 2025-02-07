import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/student_profile_setting.dart';

class StudentSettingRepository {
  final String token;

  StudentSettingRepository({required this.token});

  Future<StudentSettingModel> fetchUserData() async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/setting");

    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept-Charset": "utf-8",
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes);

        print("Decoded UTF-8 Response: $decodedResponse");

        var jsonResponse = jsonDecode(decodedResponse);
        return StudentSettingModel.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to fetch user data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}

