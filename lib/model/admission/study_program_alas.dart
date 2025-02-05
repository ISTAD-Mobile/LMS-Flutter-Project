import 'dart:convert';

List<StudyProgramAlasModel> studyProgramAlasModelFromJson(String str) => List<StudyProgramAlasModel>.from(json.decode(str).map((x) => StudyProgramAlasModel.fromJson(x)));

String studyProgramAlasModelToJson(List<StudyProgramAlasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudyProgramAlasModel {
  String? alias;
  String? studyProgramName;
  String? description;
  String? logo;

  StudyProgramAlasModel({
    this.alias,
    this.studyProgramName,
    this.description,
    this.logo,
  });

  factory StudyProgramAlasModel.fromJson(Map<String, dynamic> json) => StudyProgramAlasModel(
    alias: json["alias"],
    studyProgramName: json["studyProgramName"],
    description: json["description"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "alias": alias,
    "studyProgramName": studyProgramName,
    "description": description,
    "logo": logo,
  };
}
