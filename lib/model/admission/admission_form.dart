// To parse this JSON data, do
//
//     final admissionRequest = admissionRequestFromJson(jsonString);

import 'dart:convert';

AdmissionRequest admissionRequestFromJson(String str) => AdmissionRequest.fromJson(json.decode(str));

String admissionRequestToJson(AdmissionRequest data) => json.encode(data.toJson());

class AdmissionRequest {
  String? address;
  String? anyValuableCertificate;
  String? avatar;
  String? bacIiGrade;
  String? biography;
  String? birthPlace;
  String? classStudent;
  String? degreeAlias;
  String? diplomaSession;
  DateTime? dob;
  String? email;
  String? fatherName;
  String? fatherPhoneNumber;
  String? gender;
  String? guardianContact;
  String? guardianRelationShip;
  String? highSchool;
  String? highSchoolCertificate;
  String? identity;
  bool? isDeleted;
  String? knownIstad;
  String? motherName;
  String? motherPhoneNumber;
  String? nameEn;
  String? nameKh;
  String? phoneNumber;
  String? recommendClass;
  String? associate;
  String? shiftAlias;
  String? studentName;
  String? studyProgramAlias;
  String? telegramLink;
  String? vocationTrainingIiiCertificate;

  AdmissionRequest({
    this.address,
    this.anyValuableCertificate,
    this.avatar,
    this.bacIiGrade,
    this.biography,
    this.birthPlace,
    this.classStudent,
    this.degreeAlias,
    this.diplomaSession,
    this.dob,
    this.email,
    this.fatherName,
    this.fatherPhoneNumber,
    this.gender,
    this.guardianContact,
    this.guardianRelationShip,
    this.highSchool,
    this.highSchoolCertificate,
    this.identity,
    this.isDeleted,
    this.knownIstad,
    this.motherName,
    this.motherPhoneNumber,
    this.nameEn,
    this.nameKh,
    this.phoneNumber,
    this.recommendClass,
    this.associate,
    this.shiftAlias,
    this.studentName,
    this.studyProgramAlias,
    this.telegramLink,
    this.vocationTrainingIiiCertificate,
  });

  factory AdmissionRequest.fromJson(Map<String, dynamic> json) => AdmissionRequest(
    address: json["address"],
    anyValuableCertificate: json["anyValuableCertificate"],
    avatar: json["avatar"],
    bacIiGrade: json["bacIiGrade"],
    biography: json["biography"],
    birthPlace: json["birthPlace"],
    classStudent: json["classStudent"],
    degreeAlias: json["degreeAlias"],
    diplomaSession: json["diplomaSession"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    email: json["email"],
    fatherName: json["fatherName"],
    fatherPhoneNumber: json["fatherPhoneNumber"],
    gender: json["gender"],
    guardianContact: json["guardianContact"],
    guardianRelationShip: json["guardianRelationShip"],
    highSchool: json["highSchool"],
    highSchoolCertificate: json["highSchoolCertificate"],
    identity: json["identity"],
    isDeleted: json["isDeleted"],
    knownIstad: json["knownIstad"],
    motherName: json["motherName"],
    motherPhoneNumber: json["motherPhoneNumber"],
    nameEn: json["nameEn"],
    nameKh: json["nameKh"],
    phoneNumber: json["phoneNumber"],
    recommendClass: json["recommendClass"],
    associate: json["associate"],
    shiftAlias: json["shiftAlias"],
    studentName: json["studentName"],
    studyProgramAlias: json["studyProgramAlias"],
    telegramLink: json["telegramLink"],
    vocationTrainingIiiCertificate: json["vocationTrainingIiiCertificate"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "anyValuableCertificate": anyValuableCertificate,
    "avatar": avatar,
    "bacIiGrade": bacIiGrade,
    "biography": biography,
    "birthPlace": birthPlace,
    "classStudent": classStudent,
    "degreeAlias": degreeAlias,
    "diplomaSession": diplomaSession,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "email": email,
    "fatherName": fatherName,
    "fatherPhoneNumber": fatherPhoneNumber,
    "gender": gender,
    "guardianContact": guardianContact,
    "guardianRelationShip": guardianRelationShip,
    "highSchool": highSchool,
    "highSchoolCertificate": highSchoolCertificate,
    "identity": identity,
    "isDeleted": isDeleted,
    "knownIstad": knownIstad,
    "motherName": motherName,
    "motherPhoneNumber": motherPhoneNumber,
    "nameEn": nameEn,
    "nameKh": nameKh,
    "phoneNumber": phoneNumber,
    "recommendClass": recommendClass,
    "associate": associate,
    "shiftAlias": shiftAlias,
    "studentName": studentName,
    "studyProgramAlias": studyProgramAlias,
    "telegramLink": telegramLink,
    "vocationTrainingIiiCertificate": vocationTrainingIiiCertificate,
  };
}
