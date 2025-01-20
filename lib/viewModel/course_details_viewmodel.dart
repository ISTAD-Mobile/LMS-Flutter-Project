import 'package:flutter/material.dart';
import 'package:lms_mobile/model/course_details_model.dart';
import 'package:lms_mobile/repository/course_details_repository.dart';

class CourseDetailsViewmodel extends ChangeNotifier {
  final CourseDetailsRepository _repository = CourseDetailsRepository();
  CourseDetailResponse? courseDetail;
  bool isLoading = false;
  String? errorMessage;

  Future<void> getCourseDetail(String uuid) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      courseDetail = await _repository.fetchCourseDetail(uuid);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
