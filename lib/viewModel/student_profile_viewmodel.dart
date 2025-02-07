import 'package:flutter/material.dart';
import 'package:lms_mobile/model/student_profile_model.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';

class StudenProfileDataViewModel extends ChangeNotifier {
  final StudentProfileRepository userRepository;
  StudentProfileModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  StudenProfileDataViewModel({required this.userRepository}) {
    // Fetch user data when the ViewModel is initialized
    fetchUserData();
  }

  StudentProfileModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch user data and notify listeners on data update
  Future<void> fetchUserData() async {
    _setLoading(true);

    try {
      // Fetch user data from the repository
      _user = await userRepository.fetchUserData();
      _errorMessage = null; // Clear error message if fetch is successful
    } catch (e) {
      _errorMessage = "Failed to load user data: $e"; // Set error message
    }

    // After data is fetched or error occurs, stop loading and notify listeners
    _setLoading(false);
  }

  // Method to refresh user data (could be called manually for refresh action)
  Future<void> refreshUserData() async {
    await fetchUserData(); // Re-fetch data and update UI
  }

  // Set the loading state and notify listeners to trigger UI update
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // This ensures the UI gets updated when loading state changes
  }

}
