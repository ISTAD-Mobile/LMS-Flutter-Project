import 'package:flutter/cupertino.dart';
import '../../data/response/api_response.dart';
import '../../model/enrollment_response/place_of_birth.dart';
import '../../repository/enroll/place_of_birth_repo.dart';

class PlaceOfBirthViewModel extends ChangeNotifier {
  final PlaceOfBirthRepo placeOfBirthRepo = PlaceOfBirthRepo();
  ApiResponse<PlaceOfBirthModel> placeOfBirth = ApiResponse.loading();

  void setBlogList(ApiResponse<PlaceOfBirthModel> response) {
    placeOfBirth = response;
    notifyListeners();
  }

  Future<void> fetchPlaceOfBlogs() async {
    try {
      setBlogList(ApiResponse.loading()); // Set loading state first
      final data = await placeOfBirthRepo.getAllBlogs();
      setBlogList(ApiResponse.completed(data));
    } catch (error, stackTrace) {
      setBlogList(ApiResponse.error(error.toString()));
      debugPrint('Error fetching place of birth: $error');
    }
  }

  List<String> get placeOfBirthList {
    try {
      if (placeOfBirth.data == null) return [];
      // Access the dataList and map it to get fullName
      return placeOfBirth.data!.dataList
          .map((data) => data.fullName)
          .toList();
    } catch (e) {
      debugPrint('Error converting place of birth data: $e');
      return [];
    }
  }

  List<DataList> get fullPlaceOfBirthData {
    return placeOfBirth.data?.dataList ?? [];
  }
}