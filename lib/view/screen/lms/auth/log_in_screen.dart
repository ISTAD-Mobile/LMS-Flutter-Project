import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/lms/auth/reset_new_password_screen.dart';
import 'package:provider/provider.dart';

import '../../../../data/color/color_screen.dart';
import '../../../../repository/login_repo.dart';
import '../../../../viewModel/login_view_model.dart';
import '../../../widgets/studentsWidget/drawer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(LoginStudentRepository()),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            backgroundColor: AppColors.defaultWhiteColor,
            appBar: AppBar(
              backgroundColor: AppColors.defaultWhiteColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.defaultGrayColor
                ),
                onPressed: () => Navigator.pop(context),  // Fixed navigation
              ),
              title: const Text(
                'Login with your account',
                style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
              ),
            ),
            body: SafeArea(  // Added SafeArea
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      Image.asset('assets/images/logo_log_in.png', height: 60),
                      const SizedBox(height: 40),
                      _buildTextField(
                        label: 'Email or Username',
                        hintText: 'Enter your email or username',
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email or Username is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: viewModel.isLoading ? null : () async {
                          if (_formKey.currentState!.validate()) {
                            String emailOrUsername = emailController.text.trim();
                            String password = passwordController.text;

                            await viewModel.login(emailOrUsername, password);

                            if (!mounted) return;

                            if (viewModel.accessToken != null && viewModel.isTokenValid()) {
                              if (viewModel.isStudent) {
                                if (viewModel.isChangePassword == false) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetPasswordScreen(
                                        accessToken: viewModel.accessToken!,  // Pass token
                                        userEmail: viewModel.userEmail ?? '',  // Pass user email
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StudentScreen(
                                        accessToken: viewModel.accessToken!,
                                        userEmail: viewModel.userEmail ?? '',
                                        title: 'Student Dashboard',
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Access denied: Student account required',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    viewModel.errorMessage ?? 'Login failed. Please try again.',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: viewModel.isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.defaultWhiteColor,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.defaultWhiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    final bool isPassword = label == 'Password';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? _obscurePassword : false,  // Fixed obscureText logic
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.defaultGrayColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            )
                : null,
          ),
        ),
      ],
    );
  }
}