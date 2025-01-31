import 'package:flutter/material.dart';
import 'package:lms_mobile/resource/app_url.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../data/network/reset_password_service.dart';
import '../../../../viewModel/reset_password_view_model.dart';
import 'log_in_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String accessToken;
  final String userEmail;

  const ResetPasswordScreen({
    super.key,
    required this.userEmail,
    required this.accessToken
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ResetPasswordViewModel(
        accessToken: accessToken,
        userEmail: userEmail,
        resetPasswordService: ResetPasswordService(
            baseUrl: ApiUrl.changePassword
        ),
      ),
      child: const ResetPasswordView(),
    );
  }
}

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ResetPasswordViewModel>();

    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.defaultGrayColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Reset Password',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/images/logo_log_in.png', height: 60),
            const SizedBox(height: 40),
            PasswordField(
              controller: _passwordController,
              label: 'Password',
              obscureText: viewModel.obscurePassword,
              onToggleVisibility: viewModel.togglePasswordVisibility,
              errorText: viewModel.state.passwordError,
            ),
            const SizedBox(height: 20),
            PasswordField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              obscureText: viewModel.obscureConfirmPassword,
              onToggleVisibility: viewModel.toggleConfirmPasswordVisibility,
              errorText: viewModel.state.confirmPasswordError,
            ),
            const SizedBox(height: 30),
            ResetPasswordButton(
              isLoading: viewModel.state.isLoading,
              onPressed: () async {
                final success = await viewModel.resetPassword(
                  newPassword: _passwordController.text,
                  confirmPassword: _confirmPasswordController.text,
                  token: viewModel.accessToken,
                );

                if (success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password reset successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String? errorText;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.onToggleVisibility,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade500,
              ),
              onPressed: onToggleVisibility,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            errorText!,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ],
    );
  }
}

class ResetPasswordButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const ResetPasswordButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
Widget build(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: AppColors.defaultWhiteColor,
                strokeWidth: 2,
              ),
            )
          : const Text(
              'Reset Password',
              style: TextStyle(
                color: AppColors.defaultWhiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
    ),
  );
 }
}