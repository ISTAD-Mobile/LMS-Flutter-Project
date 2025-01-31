class StudentProfileModel {
  final String profileImage;
  final String nameEn;
  final String? nameKh;
  final String dob;
  final String degree;
  final String major;
  final String? avatar;

  StudentProfileModel({
    required this.profileImage,
    required this.nameEn,
    required this.nameKh,
    required this.dob,
    required this.degree,
    required this.major,
    this.avatar,
  });

  // Factory constructor to create a User object from JSON
  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    return StudentProfileModel(
      profileImage: json['profileImage'] ?? '',
      nameEn: json['nameEn'] ?? '',
      nameKh: json['nameKh'] ?? '',
      dob: json['dob'] ?? '',
      degree: json['degree'] ?? '',
      major: json['major'] ?? '',
      avatar: json['avatar'], // Nullable field
    );
  }
}
