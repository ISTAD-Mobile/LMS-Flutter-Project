import 'dart:convert';

import 'package:lms_mobile/model/login_model.dart';
import 'package:http/http.dart' as http;

import '../../resource/app_url.dart';

class LoginService {
  // Login API call
  Future<LoginModel> login(String emailOrUsername, String password) async {
    final url = Uri.parse(ApiUrl.login);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'emailOrUsername': emailOrUsername,
        'password': password,
      }),
    );

    // Check response status
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LoginModel.fromJson(data);
    } else {
      // Debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Login failed: ${response.body}');
    }
  }

  // Refresh token API call
  Future<LoginModel> refreshToken(String refreshToken) async {
    final url = Uri.parse(ApiUrl.refreshToken);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your-token',
      },
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LoginModel.fromJson(data);
    } else {
      print('Failed refresh token: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Token refresh failed: ${response.body}');
    }
  }
}
