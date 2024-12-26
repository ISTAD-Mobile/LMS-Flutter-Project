import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/model/students_model/profile_setting_model.dart';
import 'package:lms_mobile/repository/students_repo/profile_setting_repo.dart';

class ProfileSettingViewModel extends ChangeNotifier {
  final ProfileSettingRepo profileSettingRepo = ProfileSettingRepo();
  ApiResponse<ProfileModel> profileSetting = ApiResponse.loading();

  setProfileSetting(ApiResponse<ProfileModel> response) {
    profileSetting = response;
    notifyListeners();
  }

  Future<void> fetchProfileSetting() async {
    try {
      setProfileSetting(ApiResponse.loading());

      final response = await profileSettingRepo.getProfileSettingAllBlogs();
      setProfileSetting(ApiResponse.completed(response));
    } catch (error, stackTrace) {
      setProfileSetting(ApiResponse.error(error.toString()));
    }
  }
}