
import 'dart:convert';

EnrollModel enrollModelFromJson(String str) => EnrollModel.fromJson(json.decode(str));

String enrollModelToJson(EnrollModel data) => json.encode(data.toJson());

class EnrollModel {
  int classId;
  int studentId;

  EnrollModel({
    required this.classId,
    required this.studentId,
  });

  factory EnrollModel.fromJson(Map<String, dynamic> json) => EnrollModel(
    classId: json["classId"],
    studentId: json["studentId"],
  );

  Map<String, dynamic> toJson() => {
    "classId": classId,
    "studentId": studentId,
  };
}
