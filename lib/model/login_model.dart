// class LoginModel {
//   late final String accessToken;
//   late final String refreshToken;
//
//   LoginModel({required this.accessToken, required this.refreshToken});
//
//   // factory method to convert json to class object
//   factory LoginModel.fromJson(Map<String, dynamic> json) {
//     return LoginModel(
//         accessToken: json['access_token'] ?? '',
//         refreshToken: json['refresh_token'] ?? '');
//   }
// }


// models/user_model.dart

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
