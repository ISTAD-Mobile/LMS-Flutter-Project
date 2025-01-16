import 'package:flutter/foundation.dart';

class EnrollmentState extends ChangeNotifier {
  // Form data for all steps
  String? _fullName;
  String? _gender;
  String? _phone;
  String? _email;
  DateTime? _birthDate;
  String? _birthAddress;
  String? _currentAddress;
  String? _education;
  String? _university;
  String? _selectedCourse;
  String? _selectedClass;
  String? _selectedShift;
  String? _selectedHour;

  // Getters
  String? get fullName => _fullName;
  String? get gender => _gender;
  String? get phone => _phone;
  String? get email => _email;
  DateTime? get birthDate => _birthDate;
  String? get birthAddress => _birthAddress;
  String? get currentAddress => _currentAddress;
  String? get education => _education;
  String? get university => _university;
  String? get selectedCourse => _selectedCourse;
  String? get selectedClass => _selectedClass;
  String? get selectedShift => _selectedShift;
  String? get selectedHour => _selectedHour;

  // Step tracking
  int _currentStep = 0;
  int get currentStep => _currentStep;

  // Validation states
  bool _step1Valid = false;
  bool _step2Valid = false;
  bool _step3Valid = false;

  bool get step1Valid => _step1Valid;
  bool get step2Valid => _step2Valid;

  bool get canProceedToStep2 => _step1Valid;
  bool get canProceedToStep3 => _step2Valid;
  bool get canSubmit => _step3Valid;

  // Update step 1 data
  void updateStep1Data({
    required String fullName,
    required String gender,
    required String phone,
    required String email,
  }) {
    _fullName = fullName;
    _gender = gender;
    _phone = phone;
    _email = email;

    // Validate step 1
    _step1Valid = _fullName != null &&
        _gender != null &&
        _phone != null &&
        _email != null &&
        _fullName!.isNotEmpty &&
        _gender!.isNotEmpty &&
        _phone!.isNotEmpty &&
        _email!.isNotEmpty;

    notifyListeners();
  }

  // Update step 2 data
  void updateStep2({
    required DateTime? birthDate,
    required String? birthAddress,
    required String? currentAddress,
    required String? education,
    required String? university,
  }) {
    _birthDate = birthDate;
    _birthAddress = birthAddress;
    _currentAddress = currentAddress;
    _education = education;
    _university = university;

    // Validate step 2
    _step2Valid = _birthDate != null &&
        _birthAddress != null &&
        _currentAddress != null &&
        _education != null &&
        _university != null &&
        _birthAddress!.isNotEmpty &&
        _currentAddress!.isNotEmpty &&
        _education!.isNotEmpty &&
        _university!.isNotEmpty;

    notifyListeners();
  }

  // Update step 3 data
  void updateStep3({
    required String? selectedCourse,
    required String? selectedClass,
    required String? selectedShift,
    required String? selectedHour,
  }) {
    _selectedCourse = selectedCourse;
    _selectedClass = selectedClass;
    _selectedShift = selectedShift;
    _selectedHour = selectedHour;

    // Validate step 3
    _step3Valid = _selectedCourse != null &&
        _selectedClass != null &&
        _selectedShift != null &&
        _selectedHour != null &&
        _selectedCourse!.isNotEmpty &&
        _selectedClass!.isNotEmpty &&
        _selectedShift!.isNotEmpty &&
        _selectedHour!.isNotEmpty;

    notifyListeners();
  }

  // Navigation methods
  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  // Get all enrollment data
  Map<String, dynamic> getEnrollmentData() {
    return {
      'fullName': _fullName,
      'gender': _gender,
      'phone': _phone,
      'email': _email,
      'birthDate': _birthDate?.toIso8601String(),
      'birthAddress': _birthAddress,
      'currentAddress': _currentAddress,
      'education': _education,
      'university': _university,
      'selectedCourse': _selectedCourse,
      'selectedClass': _selectedClass,
      'selectedShift': _selectedShift,
      'selectedHour': _selectedHour,
    };
  }

  // Clear all data
  void clearAllData() {
    _fullName = null;
    _gender = null;
    _phone = null;
    _email = null;
    _birthDate = null;
    _birthAddress = null;
    _currentAddress = null;
    _education = null;
    _university = null;
    _selectedCourse = null;
    _selectedClass = null;
    _selectedShift = null;
    _selectedHour = null;
    _currentStep = 0;
    _step1Valid = false;
    _step2Valid = false;
    _step3Valid = false;
    notifyListeners();
  }
}