class AppUrl {
  static String baseUrl = "https://api.istad.co";
  static String getBlogUrl = '$baseUrl/shortcourse/api/v1/courses';
  static String getJobvacancyByUrl = '$baseUrl/website/api/v1/contents';
}

// class JobVocancyUrl {
//   static String jobvacancybaseUrl = "https://api.istad.co";
//   static String getJobvacancyByUrl = '$jobvacancybaseUrl/website/api/v1/contents';
// }

class AdmissionUrl {
  static String admisionbaseUrl = "https://dev-flutter.cstad.edu.kh/api/v1";
  static String postAdmisionByUrl = '$admisionbaseUrl/student-admissions';
}

class ApiUrl {
  static String baseUrl = 'https://dev-flutter.cstad.edu.kh/api/v1';
  static String login = '$baseUrl/auth/login';
  static String refreshToken = '$baseUrl/auth/refresh-token';
}
