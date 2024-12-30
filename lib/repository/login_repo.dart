import '../data/network/login_service.dart';
import '../data/network/token_manager.dart';

class LoginRepository {
  final LoginService _loginService = LoginService();

  // to login and save tokens
  Future<void> login(String usernameOrEmail, String password) async {
    try {
      final response = await _loginService.login(usernameOrEmail, password);

      // Save the tokens securely
      final expirationTime = DateTime.now().millisecondsSinceEpoch +
          3600 * 1000; // Set expiration time
      await TokenManager.saveTokens(
          response.accessToken, response.refreshToken, expirationTime);
    } catch (e) {
      print('Login failed: $e');
      rethrow;
    }
  }

  // to retrieve access token
  Future<String?> getAccessToken() async {
    return await TokenManager.getToken();
  }

  // to retrieve refresh token
  Future<String?> getRefreshToken() async {
    return await TokenManager.getRefreshToken();
  }

  // to refresh access token
  Future<void> refreshAccessToken() async {
    try {
      await TokenManager.refreshAccessToken();
    } catch (e) {
      print('Error refreshing access token: $e');
      rethrow;
    }
  }
}
