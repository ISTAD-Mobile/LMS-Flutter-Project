import '../../data/network/student_role_services/student_course_service.dart';
import '../../model/student_role_model/student_course_model.dart';

class StudentCoursesRepository {
  final StudentCoursesService service;

  StudentCoursesRepository({required this.service});

  Future<StudentCoursesModel> getStudentCourses() async {
    try {
      final data = await service.fetchStudentCourses();
      return StudentCoursesModel.fromJson(data);
    } catch (e) {
      print('Error fetching student courses from repository: $e');
      throw Exception('Failed to fetch student courses');
    }
  }
}
