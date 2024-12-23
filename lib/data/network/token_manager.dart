// // import 'package:flutter/cupertino.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class TokenManager {
// //   static const String _tokenKey = 'access_token';
// //   static const String _refreshTokenKey = 'refresh_token';
// //   static const String _expirationToken = 'token_expiration';
// //
// //   // save refresh token and access token when successfully login
// //   static Future<void> SaveTokens(
// //       String accessToken, String refreshToken, int expirationTime) async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     prefs.setString(_tokenKey, accessToken);
// //     prefs.setString(_refreshTokenKey, refreshToken);
// //     prefs.setInt(_expirationToken, expirationTime); // store token time
// //   }
// //
// //   // get the access token
// //   static Future<String?> getToken() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     int? expirationTime = prefs.getInt(_expirationToken);
// //
// //     // check condition if the token is expire or not
// //     if (expirationTime != null &&
// //         DateTime.now().millisecondsSinceEpoch > expirationTime) {
// //       // token is expire
// //       return null;
// //     }
// //     return prefs.getString(_tokenKey);
// //   }
// //
// //   // get the refresh token
// //   static Future<String?> getRefreshToken() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     return prefs.getString(_refreshTokenKey);
// //   }
// //
// //   // remove the token
// //   static Future<void> removeToken() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     prefs.remove(_tokenKey);
// //     prefs.remove(_refreshTokenKey);
// //     prefs.remove(_expirationToken);
// //   }
// // }
//
//
// // Updated TokenManager
// import 'package:shared_preferences/shared_preferences.dart';
//
// class TokenManager {
//   static const String _tokenKey = 'access_token';
//   static const String _refreshTokenKey = 'refresh_token';
//   static const String _expirationTokenKey = 'token_expiration';
//
//   // Save tokens and expiration time
//   static Future<void> saveTokens(
//       String accessToken, String refreshToken, int expirationTime) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, accessToken);
//     await prefs.setString(_refreshTokenKey, refreshToken);
//     await prefs.setInt(_expirationTokenKey, expirationTime);
//   }
//
//   // Get the access token
//   static Future<String?> getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int? expirationTime = prefs.getInt(_expirationTokenKey);
//
//     // Check if the token is expired
//     if (expirationTime != null &&
//         DateTime.now().millisecondsSinceEpoch > expirationTime) {
//       return null;
//     }
//     return prefs.getString(_tokenKey);
//   }
//
//   // Get the refresh token
//   static Future<String?> getRefreshToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_refreshTokenKey);
//   }
//
//   // Remove tokens
//   static Future<void> removeTokens() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_tokenKey);
//     await prefs.remove(_refreshTokenKey);
//     await prefs.remove(_expirationTokenKey);
//   }
// }