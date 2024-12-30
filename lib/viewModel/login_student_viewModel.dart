import 'package:flutter/material.dart';
import 'package:lms_mobile/model/student_profile_model.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';

class StudenProfileDataViewModel extends ChangeNotifier {
  final StudentProfileRepository userRepository;
  StudentProfileModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  StudenProfileDataViewModel({required this.userRepository});

  StudentProfileModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch user data
  Future<void> fetchUserData() async {
    try {
      _isLoading = true;
      notifyListeners();

      _user = await userRepository.fetchUserData();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
