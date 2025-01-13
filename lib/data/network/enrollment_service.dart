import 'dart:convert';
import 'package:http/http.dart' as http;

class EnrollmentService {
  Future<dynamic> postEnrollment(String url, String body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        // Return the response body as a Map
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to enroll');
      }
    } catch (e) {
      rethrow;
    }
  }
}
