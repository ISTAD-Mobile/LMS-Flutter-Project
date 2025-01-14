import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/repository/admission/admission_repository.dart';

class AdmissionViewmodel extends ChangeNotifier {
  final _admissionRepository = AdmissionRepository();
  ApiResponse<Map<String, dynamic>> response = ApiResponse.loading();

  setAdmissionData(ApiResponse<Map<String, dynamic>> response) {
    this.response = response;
    print('Admission response: $response');
    notifyListeners();
  }

  Future<Map<String, dynamic>?> postAdmission(data) async {
    setAdmissionData(ApiResponse.loading());

    try {
      final response = await _admissionRepository.postAdmission(data);

      setAdmissionData(ApiResponse.completed(response));
      return response;
    } catch (error) {
      setAdmissionData(ApiResponse.error(error.toString()));
      return null;
    }
  }
}

