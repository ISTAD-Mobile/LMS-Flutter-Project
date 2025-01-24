import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/model/course.dart';
import 'package:lms_mobile/repository/course_repository.dart';

class CourseViewmodel extends ChangeNotifier {
  final CourseRepository courseRepository = CourseRepository();
  ApiResponse<CourseResponse> course = ApiResponse.loading();

  setBlogList(ApiResponse<CourseResponse> response) {
    course = response;
    notifyListeners();
  }

  Future<dynamic> fetchAllBlogs() async {
    await courseRepository
        .getAllBlogs()
        .then((course) => setBlogList(ApiResponse.completed(course)))
        .onError(
            (error, stackTrace) => ApiResponse.error(stackTrace.toString()));
  }

  List<String> get getCourseList {
    try {
      if (course.data == null) return [];
      return course.data!.courseList.map((data) => data.title).toList();
    } catch (e) {
      debugPrint('Error converting course: $e');
      return [];
    }
  }

  List<Course> get getCourseData {
    return course.data?.courseList ?? [];
  }
}
