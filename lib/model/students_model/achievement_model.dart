// To parse this JSON data, do
//
//     final achievementModel = achievementModelFromJson(jsonString);

import 'dart:convert';

AchievementModel achievementModelFromJson(String str) => AchievementModel.fromJson(json.decode(str));

String achievementModelToJson(AchievementModel data) => json.encode(data.toJson());

class AchievementModel {
  String profileImage;
  String nameEn;
  String nameKh;
  DateTime dob;
  String degree;
  String major;
  dynamic avatar;

  AchievementModel({
    required this.profileImage,
    required this.nameEn,
    required this.nameKh,
    required this.dob,
    required this.degree,
    required this.major,
    required this.avatar,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) => AchievementModel(
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
