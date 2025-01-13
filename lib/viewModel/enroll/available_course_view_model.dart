import 'package:flutter/cupertino.dart';
import '../../data/response/api_response.dart';
import '../../model/enrollment_response/available_course_detail.dart';
import '../../model/enrollment_response/available_course_model.dart';
import '../../repository/enroll/available_course_repo.dart';

class AvailableCourseViewModel extends ChangeNotifier {
  final AvailableCourseRepo availableCourseRepo = AvailableCourseRepo();
  ApiResponse<AvailableCourseModel> availableCourse = ApiResponse.loading();
  ApiResponse<AvailableCourseDetailModel> availableCourseDetail = ApiResponse.loading();

  setAvailableCourseList(ApiResponse<AvailableCourseModel> response) {
    availableCourse = response;
    notifyListeners();
  }

  setAvailableCourseDetail(ApiResponse<AvailableCourseDetailModel> response) {
    availableCourseDetail = response;
    notifyListeners();
  }

  Future<void> fetchAvailableCourseAllBlogs() async {
    try {
      final result = await availableCourseRepo.getAvailableCourses();
      print('Fetched courses in ViewModel: ${result.availableCourseDataList.length}');
      setAvailableCourseList(ApiResponse.completed(result));
    } catch (error, stackTrace) {
      print('Error in fetchAvailableCourseAllBlogs: $error');
      print('Stack trace: $stackTrace');
      setAvailableCourseList(ApiResponse.error(error.toString()));
    }
  }

  List<AvailableCourseDataList> get getAvailableCourseData {
    final data = availableCourse.data?.availableCourseDataList ?? [];
    print('Getting available course data: ${data.length} items');
    print('uuid available course data: ${data.first.uuid} items');
    return data;
  }

  Future fetchCourseDetail(String? uuid) async {
    setAvailableCourseDetail(ApiResponse.loading());

    try {
      if (uuid == null || uuid.trim().isEmpty) {
        throw Exception('UUID cannot be null or empty');
      }

      print('Fetching course detail for UUID: $uuid');
      final detail = await availableCourseRepo.getCourseDetail(uuid);

      if (detail == null) {
        throw Exception('Received null course detail');
      }

      print('Successfully fetched course detail:');
      print('Course ID: ${detail.data.id}');
      print('Course UUID: ${detail.data.uuid}');
      print('Status Code: ${detail.code}');
      print('Message: ${detail.message}');
      print('Request Time: ${detail.requestedTime}');

      if (detail.data.classes.isEmpty) {
        print('Warning: No classes available for this course');
      } else {
        print('Number of available classes: ${detail.data.classes.length}');
      }

      setAvailableCourseDetail(ApiResponse.completed(detail));
    } catch (error, stackTrace) {
      print('Error in fetchCourseDetail: $error');
      print('Stack trace: $stackTrace');
      setAvailableCourseDetail(ApiResponse.error(error.toString()));
    }
  }
  AvailableCourseDetailModel? get getCourseDetail {
    return availableCourseDetail.data;
  }
}