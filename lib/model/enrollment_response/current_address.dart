// To parse this JSON data, do
//
//     final currentAddressModel = currentAddressModelFromJson(jsonString);

import 'dart:convert';

CurrentAddressModel currentAddressModelFromJson(String str) => CurrentAddressModel.fromJson(json.decode(str));

String currentAddressModelToJson(CurrentAddressModel data) => json.encode(data.toJson());

class CurrentAddressModel {
  int code;
  String message;
  List<CurrentAddressDataList> dataList;
  DateTime requestedTime;

  CurrentAddressModel({
    required this.code,
    required this.message,
    required this.dataList,
    required this.requestedTime,
  });

  factory CurrentAddressModel.fromJson(Map<String, dynamic> json) => CurrentAddressModel(
    code: json["code"],
    message: json["message"],
    dataList: List<CurrentAddressDataList>.from(json["dataList"].map((x) => CurrentAddressDataList.fromJson(x))),
    requestedTime: DateTime.parse(json["requestedTime"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "dataList": List<dynamic>.from(dataList.map((x) => x.toJson())),
    "requestedTime": requestedTime.toIso8601String(),
  };
}

class CurrentAddressDataList {
  int id;
  String shortName;
  String fullName;
  LocationType locationType;

  CurrentAddressDataList({
    required this.id,
    required this.shortName,
    required this.fullName,
    required this.locationType,
  });

  factory CurrentAddressDataList.fromJson(Map<String, dynamic> json) => CurrentAddressDataList(
    id: json["id"],
    shortName: json["shortName"],
    fullName: json["fullName"],
    locationType: locationTypeValues.map[json["locationType"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shortName": shortName,
    "fullName": fullName,
    "locationType": locationTypeValues.reverse[locationType],
  };
}

enum LocationType {
  K
}

final locationTypeValues = EnumValues({
  "k": LocationType.K
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}