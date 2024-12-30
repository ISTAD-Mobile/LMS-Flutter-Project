import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'login_service.dart';

class TokenManager {
  static const String _tokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _expirationToken = 'token_expiration';

  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

// Save tokens securely
  static Future<void> saveTokens(
      String accessToken, String refreshToken, int expirationTime) async {
    try {
      await _secureStorage.write(key: _tokenKey, value: accessToken);
      await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
      await _secureStorage.write(
          key: _expirationToken, value: expirationTime.toString());
      print('Tokens saved successfully.');
    } catch (e) {
      print('Error saving tokens: $e');
    }
  }

// Get the access token
  static Future<String?> getToken() async {
    try {
      final expirationTimeString =
          await _secureStorage.read(key: _expirationToken);

// Check if the token is expired
      if (expirationTimeString != null) {
        final expirationTime = int.tryParse(expirationTimeString);
        if (expirationTime != null &&
            DateTime.now().millisecondsSinceEpoch > expirationTime) {
          print('Access token has expired.');
          await removeToken(); // Optional: clear expired token
          return null;
        }
      }
// If token is not expired, return it
      return await _secureStorage.read(key: _tokenKey);
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

// Refresh the access token using the refresh token
  static Future<String?> refreshAccessToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken != null) {
        final loginService = LoginService();
        final loginModel = await loginService.refreshToken(refreshToken);

// Save new tokens and expiration time
        final newExpirationTime =
            DateTime.now().millisecondsSinceEpoch + 3600 * 1000;
        await saveTokens(
            loginModel.accessToken, loginModel.refreshToken, newExpirationTime);

        return loginModel.accessToken;
      } else {
        return null;
      }
    } catch (e) {
      print('Error refreshing access token: $e');
      return null;
    }
  }

// Get the refresh token
  static Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: _refreshTokenKey);
    } catch (e) {
      print('Error getting refresh token: $e');
      return null;
    }
  }

// Check if the token is valid, and refresh if necessary
  static Future<String?> getValidToken() async {
    String? token = await getToken();

    if (token == null) {
      print('Access token expired or unavailable. Attempting to refresh...');
      token = await refreshAccessToken();
    }

    return token;
  }

// Remove the tokens
  static Future<void> removeToken() async {
    try {
      await _secureStorage.delete(key: _tokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
      await _secureStorage.delete(key: _expirationToken);
      print('Tokens removed successfully.');
    } catch (e) {
      print('Error removing tokens: $e');
    }
  }
}
