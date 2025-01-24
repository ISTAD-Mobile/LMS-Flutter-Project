import 'dart:convert';
import 'package:http/http.dart' as http;
import '../resource/app_url.dart';

class LoginStudentRepository {
  static Future<Map<String, dynamic>> login(String emailOrUsername, String password) async {
    Uri url = Uri.parse(ApiUrl.login);
    Map<String, String> data = {
      "emailOrUsername": emailOrUsername,
      "password": password,
    };

    try {
      print("Making login request to: $url");
      print("Request data: $data");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
        body: jsonEncode(data),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        // Validate the response structure
        if (decodedResponse['accessToken'] == null) {
          return {
            'error': 'Invalid response',
            'details': 'Access token missing in response'
          };
        }

        // Return the full response for token processing in ViewModel
        return decodedResponse;
      } else {
        Map<String, dynamic> errorResponse;
        try {
          errorResponse = jsonDecode(response.body);
          return {
            'error': 'Login failed',
            'details': errorResponse['message'] ?? 'Unknown error occurred',
            'statusCode': response.statusCode
          };
        } catch (e) {
          return {
            'error': 'Login failed',
            'details': 'Failed to decode error response: ${response.body}',
            'statusCode': response.statusCode
          };
        }
      }
    } on FormatException catch (e) {
      return {
        'error': 'Format Exception',
        'details': 'Invalid response format: ${e.toString()}'
      };
    } on http.ClientException catch (e) {
      return {
        'error': 'Network Error',
        'details': 'Connection failed: ${e.toString()}'
      };
    } catch (e) {
      return {
        'error': 'Exception',
        'details': 'Unexpected error: ${e.toString()}'
      };
    }
  }

  static bool isValidJson(String str) {
    try {
      jsonDecode(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}