class StudentProfileSettingModel {
  final String gender;
  final String? profileImage;
  final String phoneNumber;
  final String? familyPhoneNumber;
  final String guardianRelationship;
  final String biography;
  final String? currentAddress;
  final String? birthPlace;

  StudentProfileSettingModel({
    required this.gender,
    this.profileImage,
    required this.phoneNumber,
    this.familyPhoneNumber,
    required this.guardianRelationship,
    required this.biography,
    this.currentAddress,
    this.birthPlace,
  });

  // Factory constructor to create a UserProfile from JSON
  factory StudentProfileSettingModel.fromJson(Map<String, dynamic> json) {
    return StudentProfileSettingModel(
      gender: json['gender'] as String,
      profileImage: json['profileImage'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      familyPhoneNumber: json['familyPhoneNumber'] as String?,
      guardianRelationship: json['guardianRelationShip'] as String,
      biography: json['biography'] as String,
      currentAddress: json['currentAddress'] as String?,
      birthPlace: json['birthPlace'] as String?,
    );
  }

  // Method to convert a UserProfile object to JSON
  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'familyPhoneNumber': familyPhoneNumber,
      'guardianRelationShip': guardianRelationship,
      'biography': biography,
      'currentAddress': currentAddress,
      'birthPlace': birthPlace,
    };
  }
}
