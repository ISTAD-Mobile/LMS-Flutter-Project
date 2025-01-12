import 'package:flutter/cupertino.dart';
import 'package:lms_mobile/model/admission/shift.dart';
import '../../data/response/api_response.dart';
import '../../repository/admission/shift_repository.dart';

class ShiftViewModel extends ChangeNotifier {
  final ShiftRepository shiftRepository = ShiftRepository();
  ApiResponse<List<ShiftModel>> shiftList = ApiResponse.loading();

  void setShiftList(ApiResponse<List<ShiftModel>> response) {
    shiftList = response;
    notifyListeners();
  }

  Future<void> fetchAllShifts() async {
    try {
      setShiftList(ApiResponse.loading());
      final data = await shiftRepository.getAllShifts();
      setShiftList(ApiResponse.completed(data));
    } catch (error, stackTrace) {
      setShiftList(ApiResponse.error(error.toString()));
      debugPrint('Error fetching shifts: $error');
    }
  }

  List<String> get shiftNames {
    try {
      if (shiftList.data == null) return [];
      return shiftList.data!.map((shift) => shift.alias).toList();
    } catch (e) {
      debugPrint('Error converting shift names: $e');
      return [];
    }
  }

  List<ShiftModel> get fullShiftData {
    return shiftList.data ?? [];
  }
}
