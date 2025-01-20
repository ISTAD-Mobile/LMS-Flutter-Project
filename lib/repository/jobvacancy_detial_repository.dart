import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/jobvacancy_detail.dart';

class JobvacancyDetialRepository {
  final String baseUrl = 'https://api.istad.co/website/api/v1';
  final String apiKey = '2uHG3FbYCvrZrT2JKRfgPBrfIax5zPwl';

  Future<JobvacancyDetailModel> fetchJobvacancyDetail(int id) async {
    final url = '$baseUrl/contents/$id';

    try {
      // Log the API URL for debugging
      print('Fetching data from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'apiKey': apiKey,
        },
      );

      print('Status code detail: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return JobvacancyDetailModel.fromJson(jsonData);
      } else {
        // Handle different status codes for better error feedback
        if (response.statusCode == 400) {
          throw Exception('Bad Request: Please check the UUID or request format.');
        } else if (response.statusCode == 404) {
          throw Exception('Not Found: The course with this UUID does not exist.');
        } else {
          throw Exception('Failed to load course details. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Something went wrong. Please try again later.');
    }
  }
}
