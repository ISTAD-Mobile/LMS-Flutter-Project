class StudentSettingModel {
  String gender;
  String? profileImage;
  final String phoneNumber;
  final String familyPhoneNumber;
  String guardianRelationShip;
  final String biography;
  final String currentAddress;
  final String birthPlace;
  final String nameEn;

  StudentSettingModel({
    required this.gender,
    this.profileImage,
    required this.phoneNumber,
    required this.familyPhoneNumber,
    required this.guardianRelationShip,
    required this.biography,
    required this.currentAddress,
    required this.birthPlace,
    required this.nameEn,
  });

  factory StudentSettingModel.fromJson(Map<String, dynamic> json) {
    return StudentSettingModel(
      gender: json['gender'],
      profileImage: json['profileImage'],
      phoneNumber: json['phoneNumber'],
      familyPhoneNumber: json['familyPhoneNumber'],
      guardianRelationShip: json['guardianRelationShip'],
      biography: json['biography'],
      currentAddress: json['currentAddress'],
      birthPlace: json['birthPlace'],
      nameEn: json['nameEn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'familyPhoneNumber': familyPhoneNumber,
      'guardianRelationShip': guardianRelationShip,
      'biography': biography,
      'currentAddress': currentAddress,
      'birthPlace': birthPlace,
      'nameEn': nameEn,
    };
  }
}
