class AppUrl {
  static String baseUrl = "https://api.istad.co/shortcourse/api/v1";
  static String getBlogUrl = '$baseUrl/courses';

  //Enrollment
  static String getPlaceOfBirthUrl = '$baseUrl/provinces?location_type=p';
  static String getUniversityUrl = '$baseUrl/universities';
  static String getCurrentAddressUrl = '$baseUrl/provinces?location_type=k';
  static String postBlogUrl = '$baseUrl/enrollments';
}

class JobVocancyUrl {
  static String jobvacancybaseUrl = "https://api.istad.co/website/api/v1";
  static String getJobvacancyByUrl = '$jobvacancybaseUrl/contents';
}
class StudentProfileUrl {
  static String studentprofileUrl = "https://dev-flutter.cstad.edu.kh/api/v1";
  static String getStudentProfileUrl = '$studentprofileUrl/students';
}


class AdmissionUrl {
  static String admisionbaseUrl = "https://dev-flutter.cstad.edu.kh/api/v1";
  static String postAdmisionByUrl = '$admisionbaseUrl/student-admissions';
}

class ApiUrl {
  static String baseUrl = 'https://dev-flutter.cstad.edu.kh/api/v1';
  static String login = '$baseUrl/auth/login';
  static String refreshToken = '$baseUrl/auth/refresh-token';
}
