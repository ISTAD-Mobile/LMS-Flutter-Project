import 'package:flutter/cupertino.dart';
import 'package:lms_mobile/repository/login_repo.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // login method
  Future<bool> login(String usernameOrEmail, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _loginRepository.login(usernameOrEmail, password);
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

  Future<bool> refreshAccessToken() async {
    try {
      await _loginRepository.refreshAccessToken();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
