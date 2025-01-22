
class PasswordValidationResult {
  final bool isValid;
  final String? errorMessage;

  PasswordValidationResult({
    required this.isValid,
    this.errorMessage,
  });
}

class ResetPasswordState {
  final bool isLoading;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? successMessage;

  ResetPasswordState({
    this.isLoading = false,
    this.passwordError,
    this.confirmPasswordError,
    this.successMessage,
  });

  ResetPasswordState copyWith({
    bool? isLoading,
    String? passwordError,
    String? confirmPasswordError,
    String? successMessage,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      successMessage: successMessage,
    );
  }
}