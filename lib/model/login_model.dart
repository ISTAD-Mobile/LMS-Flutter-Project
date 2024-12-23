class LoginModel {
  late final String accessToken;
  late final String refreshToken;

  LoginModel({required this.accessToken, required this.refreshToken});

  // factory method to convert json to class object
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        accessToken: json['access_token'] ?? '',
        refreshToken: json['refresh_token'] ?? '');
  }
}
