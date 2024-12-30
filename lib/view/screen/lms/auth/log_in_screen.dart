import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/home.dart';
import 'package:lms_mobile/view/screen/lms/auth/first_log_in_screen.dart';
import 'package:lms_mobile/view/widgets/studentsWidget/drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../viewModel/login_view_model.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.defaultGrayColor),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'Sign In with your account',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
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
                'Email or Username',
                _identifierController,
                _validateIdentifier,
              ),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FirstLogInScreen()),
                    );
                  },
                  child: const Text(
                    'First time Sign In?',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await viewModel.login(
                            _identifierController.text,
                            _passwordController.text,
                          );

                          if (success) {
                            // Assuming your login response contains these tokens
                            final String? accessToken = viewModel.accessToken;
                            final String? refreshToken = viewModel.refreshToken;

                            // Store tokens after successful login
                            await _storage.write(
                                key: 'accessToken', value: accessToken);
                            await _storage.write(
                                key: 'refreshToken', value: refreshToken);

                            // Successful login, navigate to the next screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Login Successful',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: AppColors.successColor,
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StudentScreen(title: 'Course'),
                              ),
                            );
                          } else {
                            // Login failed, show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  viewModel.errorMessage ??
                                      'An error occurred. Please try again.',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red, // Error color
                              ),
                            );
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  String? _validateIdentifier(String? value) {
    if (value == null || value.isEmpty) return 'Email or Username is required';

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final usernameRegExp = RegExp(r'^[a-zA-Z0-9_@#$&\-]{3,}$');

    if (!emailRegExp.hasMatch(value) && !usernameRegExp.hasMatch(value)) {
      return 'Enter a valid email or username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  Widget _buildTextField(String label, TextEditingController controller,
      FormFieldValidator<String> validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: 'Enter your email or username',
            hintStyle: const TextStyle(color: AppColors.defaultGrayColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          validator: _validatePassword,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            hintStyle: const TextStyle(color: AppColors.defaultGrayColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
