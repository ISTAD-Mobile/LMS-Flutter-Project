import 'package:flutter/cupertino.dart';
import 'package:lms_mobile/model/enrollment_response/current_address.dart';
import 'package:lms_mobile/repository/enroll/current_address_repo.dart';
import '../../data/response/api_response.dart';

class CurrentAddressViewModel extends ChangeNotifier {
  final CurrentAddressRepo currentAddressRepo = CurrentAddressRepo();
  ApiResponse<CurrentAddressModel> currentAddress = ApiResponse.loading();

  void setBlogList(ApiResponse<CurrentAddressModel> response) {
    currentAddress = response;
    notifyListeners();
  }

  Future<void> fetchCurrentAddressBlogs() async {
    try {
      setBlogList(ApiResponse.loading());
      final data = await currentAddressRepo.getAllBlogs();
      setBlogList(ApiResponse.completed(data));
    } catch (error, stackTrace) {
      setBlogList(ApiResponse.error(error.toString()));
      debugPrint('Error fetching current address: $error');
    }
  }

  List<String> get currentAddressList {
    try {
      if (currentAddress.data == null) return [];
      return currentAddress.data!.dataList
          .map((data) => data.fullName)
          .toList();
    } catch (e) {
      debugPrint('Error converting current address: $e');
      return [];
    }
  }

  List<CurrentAddressDataList> get fullCurrentAddressData {
    return currentAddress.data?.dataList ?? [];
  }
}