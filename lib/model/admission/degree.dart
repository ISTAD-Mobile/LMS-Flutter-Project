// To parse this JSON data, do
//
//     final degreeModel = degreeModelFromJson(jsonString);

import 'dart:convert';

List<DegreeModel> degreeModelFromJson(String str) => List<DegreeModel>.from(json.decode(str).map((x) => DegreeModel.fromJson(x)));

String degreeModelToJson(List<DegreeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DegreeModel {
  String alias;
  String level;

  DegreeModel({
    required this.alias,
    required this.level,
  });

  factory DegreeModel.fromJson(Map<String, dynamic> json) => DegreeModel(
    alias: json["alias"],
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "alias": alias,
    "level": level,
  };
}
