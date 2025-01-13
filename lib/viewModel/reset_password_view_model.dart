import 'package:flutter/foundation.dart';
import '../data/network/reset_password_service.dart';
import '../model/reset_password_model.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final String accessToken;
  final String userEmail;
  final ResetPasswordService _resetPasswordService;

  ResetPasswordState _state = ResetPasswordState();
  ResetPasswordState get state => _state;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  ResetPasswordViewModel({
    required this.accessToken,
    required this.userEmail,
    required ResetPasswordService resetPasswordService,
  }) : _resetPasswordService = resetPasswordService;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  PasswordValidationResult _validatePassword(String password) {
    if (password.isEmpty) {
      return PasswordValidationResult(
        isValid: false,
        errorMessage: 'Password is required',
      );
    }

    if (password.length < 6) {
      return PasswordValidationResult(
        isValid: false,
        errorMessage: 'Password must be at least 6 characters',
      );
    }

    bool isStrong = password.length >= 6 &&
        RegExp(r'(?=.*[A-Z])').hasMatch(password) &&
        RegExp(r'(?=.*[a-z])').hasMatch(password) &&
        RegExp(r'(?=.*\d)').hasMatch(password) &&
        RegExp(r'(?=.*[@$!%*?&])').hasMatch(password);

    if (!isStrong) {
      return PasswordValidationResult(
        isValid: false,
        errorMessage: 'Password must contain upper, lower, digit, and symbol',
      );
    }

    return PasswordValidationResult(isValid: true);
  }

  Future<bool> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {
    if (_state.isLoading) return false;

    _state = _state.copyWith(
      isLoading: true,
      passwordError: null,
      confirmPasswordError: null,
      successMessage: null,
    );
    notifyListeners();

    // Validate password
    final passwordValidation = _validatePassword(newPassword);
    if (!passwordValidation.isValid) {
      _state = _state.copyWith(
        isLoading: false,
        passwordError: passwordValidation.errorMessage,
      );
      notifyListeners();
      return false;
    }

    // Validate confirm password
    if (confirmPassword.isEmpty) {
      _state = _state.copyWith(
        isLoading: false,
        confirmPasswordError: 'Confirm password is required',
      );
      notifyListeners();
      return false;
    }

    if (confirmPassword != newPassword) {
      _state = _state.copyWith(
        isLoading: false,
        confirmPasswordError: 'Passwords do not match',
      );
      notifyListeners();
      return false;
    }

    try {
      final response = await _resetPasswordService.resetPassword(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        token: token,
      );

      if (response['success'] == true) {  // Check the 'success' key in the response map
        _state = _state.copyWith(
          isLoading: false,
          successMessage: response['message'] ?? 'Password reset successfully!',
        );
        notifyListeners();
        return true;
      } else {
        _state = _state.copyWith(
          isLoading: false,
          passwordError: response['message'] ?? 'Failed to reset password',
        );
        notifyListeners();
        return false;
      }
    } catch (error) {
      _state = _state.copyWith(
        isLoading: false,
        passwordError: 'Failed to reset password: ${error.toString()}',
      );
      notifyListeners();
      return false;
    }
  }
}