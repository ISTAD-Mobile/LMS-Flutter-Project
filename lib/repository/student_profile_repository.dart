import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_mobile/model/student_profile_model.dart';

class StudentProfileRepository {
  final String accessToken;

  StudentProfileRepository({required this.accessToken});

  // Fetch user data from the API
  Future<StudentProfileModel> fetchUserData() async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/achievement");

    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        // Decode the response body as UTF-8
        String decodedResponse = utf8.decode(response.bodyBytes);

        // Now, parse the decoded string into JSON
        var jsonResponse = jsonDecode(decodedResponse);

        // Return the StudentProfileModel from the decoded JSON
        return StudentProfileModel.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to fetch user data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}
