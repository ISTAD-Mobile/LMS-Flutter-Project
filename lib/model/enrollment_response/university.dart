
import 'dart:convert';

UniversitiesModel universitiesModelFromJson(String str) => UniversitiesModel.fromJson(json.decode(str));

String universitiesModelToJson(UniversitiesModel data) => json.encode(data.toJson());

class UniversitiesModel {
  int code;
  String message;
  List<UniversityDataList> dataList;
  DateTime requestedTime;

  UniversitiesModel({
    required this.code,
    required this.message,
    required this.dataList,
    required this.requestedTime,
  });

  factory UniversitiesModel.fromJson(Map<String, dynamic> json) => UniversitiesModel(
    code: json["code"],
    message: json["message"],
    dataList: List<UniversityDataList>.from(json["dataList"].map((x) => UniversityDataList.fromJson(x))),
    requestedTime: DateTime.parse(json["requestedTime"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "dataList": List<dynamic>.from(dataList.map((x) => x.toJson())),
    "requestedTime": requestedTime.toIso8601String(),
  };
}

class UniversityDataList {
  int id;
  String shortName;
  String fullName;

  UniversityDataList({
    required this.id,
    required this.shortName,
    required this.fullName,
  });

  factory UniversityDataList.fromJson(Map<String, dynamic> json) => UniversityDataList(
    id: json["id"],
    shortName: json["shortName"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shortName": shortName,
    "fullName": fullName,
  };
}
