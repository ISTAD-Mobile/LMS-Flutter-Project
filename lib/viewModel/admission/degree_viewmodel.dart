import 'package:flutter/cupertino.dart';
import 'package:lms_mobile/model/admission/degree.dart';
import '../../data/response/api_response.dart';
import '../../repository/admission/degree_repository.dart';

class DegreeViewModel extends ChangeNotifier {
  final DegreeRepository degreeRepository = DegreeRepository();
  ApiResponse<List<DegreeModel>> degreeList = ApiResponse.loading();

  /// Sets the degree list and notifies listeners
  void setDegreeList(ApiResponse<List<DegreeModel>> response) {
    degreeList = response;
    notifyListeners();
  }

  /// Fetches all degrees from the repository
  Future<void> fetchAllDegrees() async {
    try {
      setDegreeList(ApiResponse.loading());
      final data = await degreeRepository.getAllDegree();
      setDegreeList(ApiResponse.completed(data));
    } catch (error, stackTrace) {
      setDegreeList(ApiResponse.error(error.toString()));
      debugPrint('Error fetching degrees: $error');
    }
  }

  /// Returns a list of degree names
  List<String> get degreeNames {
    try {
      if (degreeList.data == null) return [];
      return degreeList.data!.map((degree) => degree.alias).toList();
    } catch (e) {
      debugPrint('Error converting degree names: $e');
      return [];
    }
  }

  /// Returns the full degree data list
  List<DegreeModel> get fullDegreeData {
    return degreeList.data ?? [];
  }
}
