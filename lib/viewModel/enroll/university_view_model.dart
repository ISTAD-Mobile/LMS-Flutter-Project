import 'package:flutter/cupertino.dart';
import 'package:lms_mobile/model/enrollment_response/current_address.dart';
import 'package:lms_mobile/model/enrollment_response/university.dart';
import 'package:lms_mobile/repository/enroll/current_address_repo.dart';
import 'package:lms_mobile/repository/enroll/university_repo.dart';
import '../../data/response/api_response.dart';

class UniversityViewModel extends ChangeNotifier {
  final UniversityRepo universityRepo = UniversityRepo();
  ApiResponse<UniversitiesModel> universities = ApiResponse.loading();

  void setBlogList(ApiResponse<UniversitiesModel> response) {
    universities = response;
    notifyListeners();
  }

  Future<void> fetchUniversityBlogs() async {
    try {
      setBlogList(ApiResponse.loading());
      final data = await universityRepo.getAllBlogs();
      setBlogList(ApiResponse.completed(data));
    } catch (error, stackTrace) {
      setBlogList(ApiResponse.error(error.toString()));
      debugPrint('Error fetching universities: $error');
    }
  }

  List<String> get universityList {
    try {
      if (universities.data == null) return [];
      return universities.data!.dataList
          .map((data) => data.fullName)
          .toList();
    } catch (e) {
      debugPrint('Error converting universities: $e');
      return [];
    }
  }

  List<UniversityDataList> get fullUniversitiesData {
    return universities.data?.dataList ?? [];
  }
}