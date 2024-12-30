import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:lms_mobile/data/network/token_manager.dart';

import '../../model/login_model.dart';
import '../../resource/app_url.dart';
import 'package:http/http.dart' as http;

class LoginService {
  // Login API call
  Future<LoginModel> login(String emailOrUsername, String password) async {
    final url = Uri.parse(ApiUrl.login);
    try {
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
        final loginModel = LoginModel.fromJson(data);

        // Save tokens to secure storage
        final expirationTime = DateTime.now().millisecondsSinceEpoch +
            3600 * 1000; // 1 hour expiry
        await TokenManager.saveTokens(
            loginModel.accessToken, loginModel.refreshToken, expirationTime);

        return loginModel;
      } else {
        print('Error response: ${response.statusCode} - ${response.body}');
        throw Exception('Login failed: ${response.body}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (e) {
      print('Error during login: $e');
      throw Exception('Login failed: $e');
    }
  }

  // Refresh token API call
  Future<LoginModel> refreshToken(String refreshToken) async {
    final url = Uri.parse(ApiUrl.refreshToken);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
        body: jsonEncode({'refresh_token': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final loginModel = LoginModel.fromJson(data);

        // Save the new tokens
        final expirationTime = DateTime.now().millisecondsSinceEpoch +
            3600 * 1000; // 1 hour expiry
        await TokenManager.saveTokens(
            loginModel.accessToken, loginModel.refreshToken, expirationTime);

        return loginModel;
      } else {
        print('Failed to refresh token: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Token refresh failed: ${response.body}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (e) {
      print('Error refreshing token: $e');
      throw Exception('Token refresh failed: $e');
    }
  }
}
