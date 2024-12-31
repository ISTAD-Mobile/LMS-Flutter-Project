import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnrollmentFormData {
  String? fullName;
  String? gender;
  String? phone;
  String? email;

  DateTime? birthDate;
  String? birthAddress;
  String? currentAddress;
  String? education;
  String? university;

  String? selectedCourse;
  String? selectedClass;
  String? selectedShift;
  String? selectedHour;

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'gender': gender,
    'phone': phone,
    'email': email,
    'birthDate': birthDate?.toIso8601String(),
    'birthAddress': birthAddress,
    'currentAddress': currentAddress,
    'education': education,
    'university': university,
    'selectedCourse': selectedCourse,
    'selectedClass': selectedClass,
    'selectedShift': selectedShift,
    'selectedHour': selectedHour,
  };

  static EnrollmentFormData fromJson(Map<String, dynamic> json) {
    var data = EnrollmentFormData();
    data.fullName = json['fullName'];
    data.gender = json['gender'];
    data.phone = json['phone'];
    data.email = json['email'];
    data.birthDate = json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null;
    data.birthAddress = json['birthAddress'];
    data.currentAddress = json['currentAddress'];
    data.education = json['education'];
    data.university = json['university'];
    data.selectedCourse = json['selectedCourse'];
    data.selectedClass = json['selectedClass'];
    data.selectedShift = json['selectedShift'];
    data.selectedHour = json['selectedHour'];
    return data;
  }
}

class EnrollmentStateNotifier extends ChangeNotifier {
  Map<String, dynamic> formData = {};
  void updateFormData(String key, dynamic value) {
    formData[key] = value;
    notifyListeners();
  }

  static const String _storageKey = 'enrollment_form_data';
  int _currentStep = 0;
  EnrollmentFormData _formData = EnrollmentFormData();
  bool _isLoading = false;

  int get currentStep => _currentStep;
  // EnrollmentFormData get formData => _formData;
  bool get isLoading => _isLoading;

  EnrollmentStateNotifier() {
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedDataString = prefs.getString(_storageKey);
      if (savedDataString != null) {
        final savedData = jsonDecode(savedDataString);
        _formData = EnrollmentFormData.fromJson(savedData);
      }
    } catch (e) {
      debugPrint('Error loading saved data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, jsonEncode(_formData.toJson()));
    } catch (e) {
      debugPrint('Error saving data: $e');
    }
  }

  Future<void> updateStep1({String? fullName, String? gender, String? phone, String? email}) async {
    _formData.fullName = fullName ?? _formData.fullName;
    _formData.gender = gender ?? _formData.gender;
    _formData.phone = phone ?? _formData.phone;
    _formData.email = email ?? _formData.email;
    debugPrint('Step 1 Updated: ${_formData.toJson()}');
    await _saveData();
    notifyListeners();
  }

  bool validateStep1() {
    return _formData.fullName?.isNotEmpty == true &&
        _formData.gender?.isNotEmpty == true &&
        _formData.phone?.isNotEmpty == true &&
        _formData.email?.isNotEmpty == true;
  }

  Future<void> nextStep() async {
    if (_currentStep < 2) {
      _currentStep++;
      await _saveData();
      notifyListeners();
    }
  }

  Future<void> previousStep() async {
    if (_currentStep > 0) {
      _currentStep--;
      await _saveData();
      notifyListeners();
    }
  }
}
