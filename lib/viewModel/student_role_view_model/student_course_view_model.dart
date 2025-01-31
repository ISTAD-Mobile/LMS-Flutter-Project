import '../../model/student_role_model/student_course_model.dart';
import '../../repository/student_role_repos/student_course_repo.dart';

class StudentCoursesViewModel {
  final StudentCoursesRepository repository;

  StudentCoursesViewModel({required this.repository});

  Future<StudentCoursesModel?> fetchStudentData() async {
    try {
      final data = await repository.getStudentCourses();
      return data;
    } catch (e) {
      print('Error fetching student courses in view model: $e');
      return null;
    }
  }
}
