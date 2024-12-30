// import 'package:flutter/cupertino.dart';
// import 'package:lms_mobile/repository/login_repo.dart';
//
// class LoginViewModel extends ChangeNotifier {
//   final LoginRepository _loginRepository = LoginRepository();
//
//   bool _isLoading = false;
//
//   bool get isLoading => _isLoading;
//
//   String? _errorMessage;
//
//   String? get errorMessage => _errorMessage;
//
//   // login method
//   Future<bool> login(String usernameOrEmail, String password) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       await _loginRepository.login(usernameOrEmail, password);
//       _isLoading = false;
//       notifyListeners();
//       return true;
//     } catch (e) {
//       _errorMessage = e.toString();
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }
//
//   Future<bool> refreshAccessToken() async {
//     try {
//       await _loginRepository.refreshAccessToken();
//       return true;
//     } catch (e) {
//       _errorMessage = e.toString();
//       return false;
//     }
//   }
// }




import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/login_repo.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginStudentRepository _userRepository;

  LoginViewModel(this._userRepository);

  String? accessToken;
  bool isLoading = false;
  String? errorMessage;

  Future<void> login(String emailOrUsername, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      // Call the login API
      accessToken = await _userRepository.login(emailOrUsername, password);

      if (accessToken != null) {
        print("Login successful. Access Token: $accessToken"); // Debug: Check if accessToken is retrieved
      } else {
        errorMessage = "Failed to get access token.";
        print(errorMessage); // Debug: Check the error message
      }
    } catch (e) {
      errorMessage = e.toString();
      print("Error: $errorMessage"); // Debug: Check the error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
