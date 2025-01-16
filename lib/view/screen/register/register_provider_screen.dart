import 'package:flutter/cupertino.dart';
import 'dart:convert';

class AdmissionFormData {

  String? nameEn;
  String? nameKh;
  String? phoneNumber;
  String? shiftAlias;
  String? degreeAlias;
  String? birthPlace;
  String? gender;
  DateTime? dob;
  String? email;
  String? guardianContact;
  String? classStudent;

  String? fatherName;
  String? fatherPhoneNumber;
  String? motherName;
  String? motherPhoneNumber;
  String? highSchool;
  String? address;
  String? bacIiGrade;
  String? studyProgramAlias;

  String? knownIstad;
  String? diplomaSession;
  String? vocationTrainingIiiCertificate;
  String? guardianRelationShip;

  // String? anyValuableCertificate;
  // String? avatar;
  // String? biography;
  // String? highSchoolCertificate;
  // String? identity;
  // bool? isDeleted;
  // String? recommendClass;
  // String? associate;
  // String? studentName;
  // String? telegramLink;

  Map<String, dynamic> toJson() => {
    "guardianContact": guardianContact,
    "studyProgramAlias": studyProgramAlias,
    "classStudent": classStudent,
    "email": email,
    "guardianRelationShip": guardianRelationShip,
    "address": address,
    "bacIiGrade": bacIiGrade,
    "birthPlace": birthPlace,
    "degreeAlias": degreeAlias,
    "diplomaSession": diplomaSession,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "fatherName": fatherName,
    "fatherPhoneNumber": fatherPhoneNumber,
    "gender": gender,
    "highSchool": highSchool,
    "knownIstad": knownIstad,
    "motherName": motherName,
    "motherPhoneNumber": motherPhoneNumber,
    "nameEn": nameEn,
    "nameKh": nameKh,
    "phoneNumber": phoneNumber,
    "shiftAlias": shiftAlias,
    "vocationTrainingIiiCertificate": vocationTrainingIiiCertificate,
  };

  static AdmissionFormData fromJson(Map<String, dynamic> json) {
    var admission = AdmissionFormData();
    admission.guardianContact = json['guardianContact'];
    admission.gender = json['gender'];
    admission.classStudent = json['classStudent'];
    admission.studyProgramAlias = json['studyProgramAlias'];
    admission.guardianRelationShip = json['guardianRelationShip'];
    admission.email = json['email'];
    admission.fatherName = json['fatherName'];
    admission.motherName = json['motherName'];
    admission.nameKh = json['nameKh'];
    admission.nameEn = json['nameEn'];
    admission.dob = json['dob'];
    admission.degreeAlias = json['degreeAlias'];
    admission.birthPlace = json['birthPlace'];
    admission.vocationTrainingIiiCertificate = json['vocationTrainingIiiCertificate'];
    admission.address = json['address'];
    admission.motherPhoneNumber = json['motherPhoneNumber'];
    admission.fatherPhoneNumber = json['fatherPhoneNumber'];
    admission.diplomaSession = json['diplomaSession'];
    admission.highSchool = json['highSchool'];
    admission.knownIstad = json['knownIstad'];
    admission.address = json['address'];
    admission.bacIiGrade = json['bacIiGrade'];
    admission.phoneNumber = json['phoneNumber'];

    return admission;
  }
}

// class RegisterStateNotifier extends ChangeNotifier {
//   Map<String,dynamic> formData = {};
//   void updateFormData(String key , dynamic value) {
//     formData[key] = value ;
//     notifyListeners();
//   }
//
//   static String
// }