import 'package:flutter/cupertino.dart';
import '../repository/login_repo.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

  // Login method
  Future<bool> login(String usernameOrEmail, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _loginRepository.login(usernameOrEmail, password);

      final accessToken = await _loginRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Failed to retrieve access token");
      }

      _accessToken = accessToken;

      final refreshToken = await _loginRepository.getRefreshToken();
      _refreshToken = refreshToken;

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Refresh access token method
  Future<bool> refreshAccessToken() async {
    try {
      await _loginRepository.refreshAccessToken();

      final accessToken = await _loginRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Failed to refresh access token");
      }

      _accessToken = accessToken;

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
