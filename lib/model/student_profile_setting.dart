class StudentSettingModel {
  final String gender; // 'M' or 'F'
  final String? profileImage; // Nullable, could be a URL or null
  final String phoneNumber; // Phone numbers are stored as strings
  final String familyPhoneNumber; // Same assumption as phoneNumber
  final String guardianRelationShip; // Example values: 'parents', 'guardian', 'relative', 'other'
  final String biography; // Freeform text
  final String currentAddress; // Could be a detailed address or ID, depending on your context
  final String birthPlace; // Could also represent a detailed address or ID

  StudentSettingModel({
    required this.gender,
    this.profileImage,
    required this.phoneNumber,
    required this.familyPhoneNumber,
    required this.guardianRelationShip,
    required this.biography,
    required this.currentAddress,
    required this.birthPlace,
  });

  // Factory constructor for creating a UserProfile instance from JSON
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
    );
  }

  // Method for converting a UserProfile instance to JSON
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
    };
  }
}
