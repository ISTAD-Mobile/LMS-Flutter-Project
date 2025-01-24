import 'package:flutter/material.dart';
import 'package:lms_mobile/data/response/api_response.dart';
import 'package:lms_mobile/repository/admission/admission_repository.dart';

class AdmissionViewmodel extends ChangeNotifier {
  final  _admissionRepository = AdmissionRepository();
  var response = ApiResponse();

  setAdmissionData(response) {
    this.response=response;
    notifyListeners();
  }

  Future<dynamic> postAdmission(data) async{
    print('Posting admission data: ${data}');
    print('Posting ...');
    setAdmissionData(ApiResponse.loading());
    await _admissionRepository.postAdmission(data)
        .then((isPosted) => setAdmissionData(ApiResponse.completed(isPosted)))
        .onError((error,stackTrace) => setAdmissionData(ApiResponse.error(stackTrace.toString())));
  }
}
