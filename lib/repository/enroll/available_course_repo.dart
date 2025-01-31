import 'dart:convert';

import '../../data/network/api_service.dart';
import '../../model/enrollment_response/available_course_model.dart';
import '../../model/enrollment_response/available_course_detail.dart';
import '../../resource/app_url.dart';

class AvailableCourseRepo {
  final ApiService apiService = ApiService();

  Future<AvailableCourseModel> getAvailableCourses() async {
    try {
      // Fetch data from API
      final availableCourseData = await apiService.getApiService(AppUrl.getAvailableBlogUrl);
      print('Fetched data: $availableCourseData');

      // Parse data into the model
      final model = availableCourseModelFromJson(availableCourseData);

      // Logging for debugging
      print('Parsed courses count: ${model.availableCourseDataList.length}');
      if (model.availableCourseDataList.isNotEmpty) {
        print('First course title: ${model.availableCourseDataList.first.title}');
      }

      return model;
    } catch (e, stackTrace) {
      // Log the error and rethrow
      print('Error in getAvailableCourses: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to fetch available courses.');
    }
  }

  Future getCourseDetail(String? uuid) async {
    try {
      // Enhanced UUID validation
      if (uuid == null || uuid.trim().isEmpty) {
        print('Error: UUID is null or empty. UUID value: $uuid');
        throw Exception('Invalid UUID provided: UUID cannot be null or empty');
      }

      // Clean the UUID and URL
      final cleanUuid = uuid.trim();
      final url = '${AppUrl.getBlogUrl.trim()}/$cleanUuid/classes'.trim();
      print('Requesting URL: $url');

      // Fetch data from API
      final courseDetailData = await apiService.getApiService(url);

      // Enhanced response validation
      if (courseDetailData == null) {
        throw Exception('API returned null response');
      }

      if (courseDetailData.trim().isEmpty) {
        throw Exception('API returned empty response');
      }

      print('Successfully received API response for UUID: $cleanUuid');
      return availableCourseDetailModelFromJson(courseDetailData);

    } catch (e, stackTrace) {
      print('Error in getCourseDetail: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to fetch course detail: ${e.toString()}');
    }
  }
}