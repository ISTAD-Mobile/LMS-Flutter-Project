import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lms_mobile/data/network/login_service.dart';

class LoginRepository {
  final LoginService _loginService = LoginService();
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  // to save token securely
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _flutterSecureStorage.write(key: 'access_token', value: accessToken);
    await _flutterSecureStorage.write(
        key: 'refresh_token', value: refreshToken);
  }

  // to retrieve tokens
  Future<String?> getAccessToken() async {
    return await _flutterSecureStorage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _flutterSecureStorage.read(key: 'refresh_token');
  }

  // to login and save tokens
  Future<void> login(String usernameOrEmail, String password) async {
    final response = await _loginService.login(usernameOrEmail, password);
    await saveTokens(response.accessToken, response.refreshToken);
  }

  // to refresh access token
  Future<void> refreshAccessToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      throw Exception('Refresh token not found');
    }

    final response = await _loginService.refreshToken(refreshToken);
    await saveTokens(response.accessToken, refreshToken);
  }
}
