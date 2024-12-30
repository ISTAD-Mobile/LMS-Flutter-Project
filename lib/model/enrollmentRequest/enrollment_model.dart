// To parse this JSON data, do
//
//     final enrollmentModel = enrollmentModelFromJson(jsonString);

import 'dart:convert';

EnrollmentModel enrollmentModelFromJson(String str) => EnrollmentModel.fromJson(json.decode(str));

String enrollmentModelToJson(EnrollmentModel data) => json.encode(data.toJson());

class EnrollmentModel {
  int id;
  String uuid;
  String email;
  String nameEn;
  dynamic nameKh;
  String gender;
  DateTime dob;
  CurrentAddress pob;
  CurrentAddress currentAddress;
  String phoneNumber;
  String photoUri;
  CurrentAddress universityInfo;

  EnrollmentModel({
    required this.id,
    required this.uuid,
    required this.email,
    required this.nameEn,
    required this.nameKh,
    required this.gender,
    required this.dob,
    required this.pob,
    required this.currentAddress,
    required this.phoneNumber,
    required this.photoUri,
    required this.universityInfo,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) => EnrollmentModel(
    id: json["id"],
    uuid: json["uuid"],
    email: json["email"],
    nameEn: json["nameEn"],
    nameKh: json["nameKh"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    pob: CurrentAddress.fromJson(json["pob"]),
    currentAddress: CurrentAddress.fromJson(json["currentAddress"]),
    phoneNumber: json["phoneNumber"],
    photoUri: json["photoUri"],
    universityInfo: CurrentAddress.fromJson(json["universityInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "email": email,
    "nameEn": nameEn,
    "nameKh": nameKh,
    "gender": gender,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "pob": pob.toJson(),
    "currentAddress": currentAddress.toJson(),
    "phoneNumber": phoneNumber,
    "photoUri": photoUri,
    "universityInfo": universityInfo.toJson(),
  };
}

class CurrentAddress {
  int id;
  String shortName;
  String fullName;
  String? locationType;

  CurrentAddress({
    required this.id,
    required this.shortName,
    required this.fullName,
    this.locationType,
  });

  factory CurrentAddress.fromJson(Map<String, dynamic> json) => CurrentAddress(
    id: json["id"],
    shortName: json["shortName"],
    fullName: json["fullName"],
    locationType: json["locationType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shortName": shortName,
    "fullName": fullName,
    "locationType": locationType,
  };
}
