// import 'package:flutter/foundation.dart';
// import 'package:lms_mobile/repository/update_student_profile_setting_repository.dart';
// import '../model/student_profile_setting.dart';
//
// class UpdataStudentProfileSettingViewmodel extends ChangeNotifier {
//   final UpdateStudentProfileSettingRepository _repository;
//   StudentSettingModel? _userData;
//   bool _isLoading = false;
//   String _errorMessage = '';
//
//   UpdataStudentProfileSettingViewmodel({required UpdateStudentProfileSettingRepository repository}) : _repository = repository;
//
//   StudentSettingModel? get userData => _userData;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;
//
//   Future<void> fetchUserData() async {
//     _isLoading = true;
//     _errorMessage = '';
//     notifyListeners();
//
//     try {
//       _userData = await _repository.fetchUdateData();
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
//


import 'package:flutter/foundation.dart';
import 'package:lms_mobile/repository/update_student_profile_setting_repository.dart';
import '../model/student_profile_setting.dart';

class UpdataStudentProfileSettingViewmodel extends ChangeNotifier {
  final UpdateStudentProfileSettingRepository _repository;
  StudentSettingModel? _userData;
  bool _isLoading = false;
  String _errorMessage = '';

  UpdataStudentProfileSettingViewmodel({required UpdateStudentProfileSettingRepository repository}) : _repository = repository;

  StudentSettingModel? get userData => _userData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUserData() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _userData = await _repository.fetchUdateData();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserData({
    required String guardianRelationShip,
    required String birthPlace,
    required String gender,
    required String currentAddress,
    required String phoneNumber,
    required String familyPhoneNumber,
    required String biography,
    required String profileImage
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final studentSetting = StudentSettingModel(
      guardianRelationShip: guardianRelationShip,
      birthPlace: birthPlace,
      gender: gender,
      currentAddress: currentAddress,
      phoneNumber: phoneNumber,
      familyPhoneNumber: familyPhoneNumber,
      biography: biography,
      profileImage: profileImage,
    );

    try {
      final success = await _repository.updateStudentProfileSetting(studentSetting);

      if (success) {
        _userData = studentSetting;
        print("Profile updated successfully!");
      }
    } catch (e) {
      _errorMessage = 'Failed to update profile: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

