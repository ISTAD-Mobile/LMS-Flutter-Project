import 'package:flutter/material.dart';
import 'package:lms_mobile/model/student_profile_model.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';

class StudenProfileDataViewModel extends ChangeNotifier {
  final StudentProfileRepository userRepository;
  StudentProfileModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isDisposed = false; // Track if disposed

  StudenProfileDataViewModel({required this.userRepository});

  StudentProfileModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch user data
  Future<void> fetchUserData() async {
    _setLoading(true);

    try {
      _user = await userRepository.fetchUserData();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _setLoading(false);
  }

  void _setLoading(bool value) {
    if (_isDisposed) return; // Prevent updates after disposal
    _isLoading = value;
    Future.microtask(() {
      if (!_isDisposed) notifyListeners();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
