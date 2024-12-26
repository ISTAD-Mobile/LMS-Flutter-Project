import 'package:lms_mobile/data/network/api_service.dart';
import 'package:lms_mobile/model/student_profile.dart';
import '../resource/app_url.dart';

class StudentProfileRepository {
  final ApiService apiService = ApiService();

  Future<StudentProfile> getStudentProfile() async {
    try {
      // Get the data from the API
      dynamic response = await apiService.getApiService(StudentProfileUrl.getStudentProfileUrl);

      // Parse the response and return the StudentProfile object
      return studentProfileFromJson(response);  // Pass the response directly
    } catch (exception) {
      rethrow; // Rethrow the exception for further handling
    }
  }
}
