// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:lms_mobile/data/network/login_service.dart';
//
// class LoginRepository {
//   final LoginService _loginService = LoginService();
//   final FlutterSecureStorage _flutterSecureStorage =
//       const FlutterSecureStorage();
//
//   // to save token securely
//   Future<void> saveTokens(String accessToken, String refreshToken) async {
//     await _flutterSecureStorage.write(key: 'access_token', value: accessToken);
//     await _flutterSecureStorage.write(
//         key: 'refresh_token', value: refreshToken);
//   }
//
//   // to retrieve tokens
//   Future<String?> getAccessToken() async {
//     return await _flutterSecureStorage.read(key: 'access_token');
//   }
//
//   Future<String?> getRefreshToken() async {
//     return await _flutterSecureStorage.read(key: 'refresh_token');
//   }
//
//   // to login and save tokens
//   Future<void> login(String usernameOrEmail, String password) async {
//     final response = await _loginService.login(usernameOrEmail, password);
//     await saveTokens(response.accessToken, response.refreshToken);
//   }
//
//   // to refresh access token
//   Future<void> refreshAccessToken() async {
//     final refreshToken = await getRefreshToken();
//     if (refreshToken == null) {
//       throw Exception('Refresh token not found');
//     }
//
//     final response = await _loginService.refreshToken(refreshToken);
//     await saveTokens(response.accessToken, refreshToken);
//   }
// }




// repositories/user_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginStudentRepository {
  Future<String?> login(String emailOrUsername, String password) async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/auth/login");
    var data = {
      "emailOrUsername": emailOrUsername,
      "password": password,
    };

    try {
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      print("API Response: ${response.body}"); // Debug: Log the API response

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData['accessToken']; // Return the access token
      } else {
        throw Exception("Login failed: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
