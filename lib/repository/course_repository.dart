import 'package:lms_mobile/data/network/api_service.dart';
import 'package:lms_mobile/model/course.dart';
import 'package:lms_mobile/resource/app_url.dart';

class CourseRepository{
  final ApiService apiService = ApiService();

  Future<CourseResponse> getAllBlogs() async {
    try{
      final courseData = await apiService.getApiService(AppUrl.getBlogUrl);
      print("Course Data: $courseData");
      return courseFromJson(courseData);
    }catch (exception) {
      rethrow;
    }
  }
}