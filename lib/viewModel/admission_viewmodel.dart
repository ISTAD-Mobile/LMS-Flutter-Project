import 'package:flutter/material.dart';
import 'package:lms_mobile/data/network/api_service.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/model/request/admission.dart';
import 'package:lms_mobile/repository/admission_repository.dart';

class AdmissionViewmodel extends ChangeNotifier {
  final  _admissionRepository = AdmissionRepository();
  var response = ApiService();

  setAdmissionData(response) {
    this.response=response;
    notifyListeners();
  }

  Future<dynamic> postAdmission(data) async{
    await _admissionRepository.postAdmission(data)
        .then((value) => setAdmissionData(ApiResponse.completed(value)))
        .onError((error,stackTrace) => setAdmissionData(ApiResponse.error(stackTrace.toString())));
  }
}
