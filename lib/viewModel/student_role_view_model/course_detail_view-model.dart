import 'package:flutter/cupertino.dart';
import 'package:lms_mobile/repository/student_role_repos/course_detail_repo.dart';

import '../../model/student_role_model/course_detail_model.dart';

class CourseDetailViewModel extends ChangeNotifier {
  final CourseDetailRepoRepository _courseDetailRepoRepository =
      CourseDetailRepoRepository();

  CourseDetailModel? courseDetail;
  bool isLoading = false;

  Future<void> fetchCourseDetail(String courseId) async {
    isLoading = true;
    notifyListeners();

    try {
      courseDetail =
          await _courseDetailRepoRepository.getCourseDetail(courseId);
    } catch (e) {
      print('Error fetching course detail: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
