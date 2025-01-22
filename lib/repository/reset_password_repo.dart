import '../data/network/reset_password_service.dart';

class ResetPasswordRepository {
  final ResetPasswordService _service;

  ResetPasswordRepository(this._service);

  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      return await _service.resetPassword(
        token: token,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      return {
        'success': false,
        'message': 'Repository error: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> resetPasswordSimple({
    required String token,
    required String newPassword,
  }) async {
    return resetPassword(
      token: token,
      newPassword: newPassword,
      confirmPassword: newPassword,
    );
  }
}