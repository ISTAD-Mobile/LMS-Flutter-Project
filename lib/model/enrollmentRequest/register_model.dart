import 'dart:convert';

EnrollmentModel enrollmentModelFromJson(String str) => EnrollmentModel.fromJson(json.decode(str));

String enrollmentModelToJson(EnrollmentModel data) => json.encode(data.toJson());

class EnrollmentModel {
  String email;
  String nameEn;
  String gender;
  final DateTime? dob;
  CurrentAddress pob;
  CurrentAddress currentAddress;
  String phoneNumber;
  String photoUri;
  CurrentAddress universityInfo;

  EnrollmentModel({
    required this.email,
    required this.nameEn,
    required this.gender,
    this.dob,
    required this.pob,
    required this.currentAddress,
    required this.phoneNumber,
    required this.photoUri,
    required this.universityInfo,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) =>
      EnrollmentModel(
        email: json["email"],
        nameEn: json["nameEn"],
        gender: json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        pob: CurrentAddress.fromJson(json["pob"]),
        currentAddress: CurrentAddress.fromJson(json["currentAddress"]),
        phoneNumber: json["phoneNumber"],
        photoUri: json["photoUri"],
        universityInfo: CurrentAddress.fromJson(json["universityInfo"]),
      );

  Map<String, dynamic> toJson() => {
    "email": email,
    "nameEn": nameEn,
    "gender": gender,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
  String nameEn;
  String? locationType;

  CurrentAddress({
    required this.id,
    required this.shortName,
    required this.nameEn,
    this.locationType,
  });

  factory CurrentAddress.fromJson(Map<String, dynamic> json) => CurrentAddress(
    id: json["id"],
    shortName: json["shortName"],
    nameEn: json["nameEn"],
    locationType: json["locationType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shortName": shortName,
    "nameEn": nameEn,
    "locationType": locationType,
  };
}
