
class LoginModel {
  final String emailOrUsername;
  final String password;

  LoginModel({required this.emailOrUsername, required this.password});

  // You can also create a factory constructor for easy JSON parsing if needed
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      emailOrUsername: json['emailOrUsername'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailOrUsername': emailOrUsername,
      'password': password,
    };
  }
}
