import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:lms_mobile/resource/app_url.dart';

class ResetPasswordService {
  final String baseUrl;

  ResetPasswordService({required this.baseUrl});

  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      return {
        'success': false,
        'message': 'Password fields cannot be empty',
      };
    }

    if (newPassword != confirmPassword) {
      return {
        'success': false,
        'message': 'Passwords do not match',
      };
    }

    if (newPassword.length < 8) {
      return {
        'success': false,
        'message': 'Password must be at least 8 characters long',
      };
    }

    try {
      final response = await http
          .put(
        Uri.parse(ApiUrl.changePassword),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        }),
      )
          .timeout(const Duration(seconds: 10));

      print('Response Status: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Body: ${response.body}');

      switch (response.statusCode) {
        case 200:
        case 204:
          return {
            'success': true,
            'message': 'Password successfully reset',
          };
        case 404:
          return {
            'success': false,
            'message': 'API endpoint not found. Please check the URL.',
          };
        case 400:
        case 422:
        case 500:
          try {
            final errorData = jsonDecode(response.body);
            return {
              'success': false,
              'message': errorData['message'] ?? 'An error occurred',
            };
          } catch (_) {
            return {
              'success': false,
              'message': 'Unexpected server response format',
            };
          }
        case 401:
          return {
            'success': false,
            'message': 'Unauthorized. Please log in again.',
          };
        default:
          return {
            'success': false,
            'message': 'An unexpected error occurred. Please try again.',
          };
      }
    } on http.ClientException catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.message}',
      };
    } on FormatException catch (_) {
      return {
        'success': false,
        'message': 'Invalid response format from server',
      };
    } on TimeoutException catch (_) {
      return {
        'success': false,
        'message': 'Request timed out. Please try again.',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }
}