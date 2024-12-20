import 'package:flutter/cupertino.dart';

class AppUrl {
  static String baseUrl = "https://api.istad.co/shortcourse/api/v1";
  static String getBlogUrl = '$baseUrl/courses';
}

class JobVocancyUrl {
  static String jobvacancybaseUrl = "https://api.istad.co/website/api/v1";
  static String getJobvacancyByUrl = '$jobvacancybaseUrl/contents';
}

class ApiUrl {
  static String baseUrl = 'https://dev-flutter.cstad.edu.kh/api/v1';
  static String login = '$baseUrl/auth/login';
  static String refreshToken = '$baseUrl/auth/refresh-token';
}
