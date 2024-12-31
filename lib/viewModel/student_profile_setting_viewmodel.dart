import 'package:flutter/foundation.dart';

import '../model/student_profile_setting.dart';
import '../repository/student_profile_setting_repository.dart';

class StudentSettingViewModel extends ChangeNotifier {
  final StudentSettingRepository _repository;
  StudentSettingModel? _userData;
  bool _isLoading = false;
  String _errorMessage = '';

  StudentSettingViewModel({required StudentSettingRepository repository}) : _repository = repository;

  StudentSettingModel? get userData => _userData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUserData() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _userData = await _repository.fetchUserData();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

