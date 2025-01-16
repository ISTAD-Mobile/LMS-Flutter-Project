import 'dart:convert';

class AppUrl {
  static String baseUrl = "https://api.istad.co/shortcourse/api/v1";
  static String getBlogUrl = '$baseUrl/courses';
  static String getAvailableBlogUrl = '$getBlogUrl/available';

  //Enrollment
  static String getPlaceOfBirthUrl = '$baseUrl/provinces?location_type=p';
  static String getUniversityUrl = '$baseUrl/universities';
  static String getCurrentAddressUrl = '$baseUrl/provinces?location_type=k';
  static String postBlogRegisterUrl = '$baseUrl/students';
  static String postBlogEnrollmentUrl = '$baseUrl/enrollments';
}

class JobVocancyUrl {
  static String jobvacancybaseUrl = "https://api.istad.co/website/api/v1";
  static String getJobvacancyByUrl = '$jobvacancybaseUrl/contents';
}
class StudentProfileUrl {
  static String baseUrl = "https://dev-flutter.cstad.edu.kh/api/v1";
  static String getStudentProfileUrl = '$baseUrl/students';
}


class AdmissionUrl {
  static String admisionbaseUrl = "https://dev-flutter.cstad.edu.kh/api/v1";
  static String postAdmisionByUrl = '$admisionbaseUrl/student-admissions';
}

class ApiUrl {
  static String baseUrl = 'https://dev-flutter.cstad.edu.kh/api/v1';
  static String login = '$baseUrl/auth/login';
  static String changePassword = '$baseUrl/auth/passwords';
  static String refreshToken = '$baseUrl/auth/refresh';
  static String postImageByUrl = '$baseUrl/medias/upload-single';
  static String getGraduationUrl = '$baseUrl/graduations';
}
