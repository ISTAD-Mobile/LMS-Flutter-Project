
import 'dart:convert';

PlaceOfBirthModel placeOfBirthModelFromJson(String str) => PlaceOfBirthModel.fromJson(json.decode(str));

String placeOfBirthModelToJson(PlaceOfBirthModel data) => json.encode(data.toJson());

class PlaceOfBirthModel {
  int code;
  String message;
  List<DataList> dataList;
  DateTime requestedTime;

  PlaceOfBirthModel({
    required this.code,
    required this.message,
    required this.dataList,
    required this.requestedTime,
  });

  factory PlaceOfBirthModel.fromJson(Map<String, dynamic> json) => PlaceOfBirthModel(
    code: json["code"],
    message: json["message"],
    dataList: List<DataList>.from(json["dataList"].map((x) => DataList.fromJson(x))),
    requestedTime: DateTime.parse(json["requestedTime"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "dataList": List<dynamic>.from(dataList.map((x) => x.toJson())),
    "requestedTime": requestedTime.toIso8601String(),
  };
}

class DataList {
  int id;
  String shortName;
  String fullName;
  LocationType locationType;

  DataList({
    required this.id,
    required this.shortName,
    required this.fullName,
    required this.locationType,
  });

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
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
  P
}

final locationTypeValues = EnumValues({
  "p": LocationType.P
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
