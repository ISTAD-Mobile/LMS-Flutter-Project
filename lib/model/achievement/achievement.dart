import 'dart:convert';

Achievement achievementFromJson(String str) => Achievement.fromJson(json.decode(str));

String achievementToJson(Achievement data) => json.encode(data.toJson());

class Achievement {
  dynamic profileImage;
  String nameEn;
  String nameKh;
  DateTime dob;
  String degree;
  String major;
  dynamic avatar;

  Achievement({
    required this.profileImage,
    required this.nameEn,
    required this.nameKh,
    required this.dob,
    required this.degree,
    required this.major,
    required this.avatar,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
    profileImage: json["profileImage"],
    nameEn: json["nameEn"],
    nameKh: json["nameKh"],
    dob: DateTime.parse(json["dob"]),
    degree: json["degree"],
    major: json["major"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "profileImage": profileImage,
    "nameEn": nameEn,
    "nameKh": nameKh,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "degree": degree,
    "major": major,
    "avatar": avatar,
  };
}
