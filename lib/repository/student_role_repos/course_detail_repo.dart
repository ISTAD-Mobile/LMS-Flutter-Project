import '../../data/network/student_role_services/course_detail_service.dart';
import '../../model/student_role_model/course_detail_model.dart';

class CourseDetailRepoRepository {
  final CourseService _courseService = CourseService();

  Future<CourseDetailModel> getCourseDetail(String courseId) {
    return _courseService.fetchCourseDetail(courseId);
  }
}
