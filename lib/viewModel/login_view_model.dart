import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../repository/login_repo.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginStudentRepository _userRepository;

  LoginViewModel(this._userRepository);

  String? accessToken;
  bool isLoading = false;
  String? errorMessage;
  bool? isChangePassword;
  bool neverChangedPassword = false;
  String? userEmail;  // Added for storing email from JWT
  List<String> roles = [];  // Added for storing roles from JWT
  Map<String, dynamic>? decodedToken;
  bool isTokenValid() {
    if (accessToken == null) return false;
    try {
      return !JwtDecoder.isExpired(accessToken!);
    } catch (e) {
      print("Error checking token validity: $e");
      return false;
    }
  }

  // Check if user has student role
  bool get isStudent => roles.contains('student');

  Future<void> login(String emailOrUsername, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await LoginStudentRepository.login(emailOrUsername, password);

      if (response['error'] != null) {
        errorMessage = response['details'];
        if (response['statusCode'] == 401) {
          errorMessage = 'Invalid username or password';
        } else if (response['statusCode'] == 404) {
          errorMessage = 'User not found';
        } else if (response['statusCode'] == 403) {
          errorMessage = 'Account is locked or inactive';
        }
        print("Login failed: $errorMessage");
        return;
      }

      // Process successful response
      accessToken = response['accessToken'];
      if (accessToken == null || accessToken!.isEmpty) {
        errorMessage = "Failed to get access token.";
        print(errorMessage);
        return;
      }

      // Decode JWT token
      try {
        decodedToken = JwtDecoder.decode(accessToken!);
        print("Decoded Token: $decodedToken");

        // Extract user email from 'sub' claim
        userEmail = decodedToken!['sub'];

        // Extract roles
        if (decodedToken!['roles'] != null) {
          roles = List<String>.from(decodedToken!['roles']);
        }
        // Extract isChangePassword
        isChangePassword = decodedToken!['isChangePassword'];

        print("User Email: $userEmail");
        print("Roles: $roles");

      } catch (e) {
        print("Error decoding token: $e");
        errorMessage = "Invalid token format";
        return;
      }

    } catch (e) {
      errorMessage = 'Unexpected error occurred';
      print("Error: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

