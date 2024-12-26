import 'package:lms_mobile/data/network/profile_setting_service.dart';
import 'package:lms_mobile/resource/app_url.dart';
import '../../model/students_model/profile_setting_model.dart';

class ProfileSettingRepo {
  final ProfileSettingService profileSettingService = ProfileSettingService();

  Future<ProfileModel> getProfileSettingAllBlogs() async {
    try{
      final profileSettingData = await profileSettingService.getProfileSettingApiService(ApiUrl.profileSetting);
      return profileModelFromJson(profileSettingData);
    }catch (exception) {
      rethrow;
    }
  }
}