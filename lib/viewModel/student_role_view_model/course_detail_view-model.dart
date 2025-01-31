import 'package:flutter/material.dart';
import 'package:lms_mobile/model/student_role_model/course_detail_model.dart';
import 'package:lms_mobile/repository/student_role_repos/course_detail_repo.dart';

class StudentCourseDetailsViewmodel extends ChangeNotifier {
  final StudentCourseDetailsRepository _repository;
  StudentCourseDetailModel? studentCourseDetail;
  bool isLoading = false;
  String? errorMessage;


  StudentCourseDetailsViewmodel({required String token})
      : _repository = StudentCourseDetailsRepository(token: token);

  Future<void> getStudentCourseDetail(String uuid) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      studentCourseDetail = await _repository.fetchStudentCourseDetail(uuid);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
