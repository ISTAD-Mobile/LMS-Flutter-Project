import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/student_role_repos/course_detail_repo.dart';
import '../../model/student_role_model/course_detail_model.dart';

class StudentCourseDetailsViewModel extends ChangeNotifier {
  final StudentCourseDetailsRepository repository;
  StudentCourseDetailModel? course;
  bool isLoading = false;
  String? errorMessage;

  StudentCourseDetailsViewModel({required this.repository});

  Future<void> getCourseDetails(String courseId) async {
    isLoading = true;
    notifyListeners();

    try {
      course = await repository.fetchStudentCourseDetails(courseId);
      errorMessage = null;
    } catch (error) {
      errorMessage = error.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
