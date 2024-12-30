class LoginModel {
  late final String accessToken;
  late final String refreshToken;

  // Constructor
  LoginModel({required this.accessToken, required this.refreshToken});

  // Factory method to convert json to class object
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    // Using `??` to handle cases where keys might be missing or null
    return LoginModel(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
