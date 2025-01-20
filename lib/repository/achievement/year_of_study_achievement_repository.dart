import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/achievement/year_of_study_achievement.dart';

class YearOfStudyAchievementRepository {
  final String accessToken;

  YearOfStudyAchievementRepository({required this.accessToken});

  Future<YearOfStudyAchievementModel> fetchYearOfStudyData() async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/students/year-of-study-achievement");

    try {
      print("Fetching year of study data...");
      print("Access Token: $accessToken");

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        print("Repository : $jsonResponse");

        if (jsonResponse.containsKey('content')) {
          // Wrap the entire response into the model.
          return YearOfStudyAchievementModel.fromJson(jsonResponse);
        } else {
          throw Exception("No 'content' key found in the response.");
        }
      } else {
        throw Exception("Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching year of study data: $e");
      throw Exception("Error fetching year of study data: $e");
    }
  }
}
