import 'dart:convert';

StudentProfile studentProfileFromJson(String str) => StudentProfile.fromJson(json.decode(str));

String studentProfileToJson(StudentProfile data) => json.encode(data.toJson());

class StudentProfile {
  List<Content> content;

  StudentProfile({
    required this.content,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) => StudentProfile(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
  };
}

class Content {
  String uuid;
  String cardId;
  int studentStatus;
  String profileImage;
  String nameEn;
  String nameKh;
  String gender;
  String email;
  String username;
  String phoneNumber;
  String guardianRelationShip;
  String? familyPhoneNumber;
  String? birthPlace;
  String? currentAddress;
  String biography;
  DateTime dob;
  String bacIiGrade;
  String highSchoolCertificate;
  dynamic vocationTrainingCertificate;
  String? anyValuableCertificate;

  Content({
    required this.uuid,
    required this.cardId,
    required this.studentStatus,
    required this.profileImage,
    required this.nameEn,
    required this.nameKh,
    required this.gender,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.guardianRelationShip,
    required this.familyPhoneNumber,
    required this.birthPlace,
    required this.currentAddress,
    required this.biography,
    required this.dob,
    required this.bacIiGrade,
    required this.highSchoolCertificate,
    required this.vocationTrainingCertificate,
    required this.anyValuableCertificate,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    uuid: json["uuid"],
    cardId: json["cardId"],
    studentStatus: json["studentStatus"],
    profileImage: json["profileImage"],
    nameEn: json["nameEn"],
    nameKh: json["nameKh"],
    gender: json["gender"],
    email: json["email"],
    username: json["username"],
    phoneNumber: json["phoneNumber"],
    guardianRelationShip: json["guardianRelationShip"],
    familyPhoneNumber: json["familyPhoneNumber"],
    birthPlace: json["birthPlace"],
    currentAddress: json["currentAddress"],
    biography: json["biography"],
    dob: DateTime.parse(json["dob"]),
    bacIiGrade: json["bacIiGrade"],
    highSchoolCertificate: json["highSchoolCertificate"],
    vocationTrainingCertificate: json["vocationTrainingCertificate"],
    anyValuableCertificate: json["anyValuableCertificate"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "cardId": cardId,
    "studentStatus": studentStatus,
    "profileImage": profileImage,
    "nameEn": nameEn,
    "nameKh": nameKh,
    "gender": gender,
    "email": email,
    "username": username,
    "phoneNumber": phoneNumber,
    "guardianRelationShip": guardianRelationShip,
    "familyPhoneNumber": familyPhoneNumber,
    "birthPlace": birthPlace,
    "currentAddress": currentAddress,
    "biography": biography,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "bacIiGrade": bacIiGrade,
    "highSchoolCertificate": highSchoolCertificate,
    "vocationTrainingCertificate": vocationTrainingCertificate,
    "anyValuableCertificate": anyValuableCertificate,
  };
}
