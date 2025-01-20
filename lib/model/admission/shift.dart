// To parse this JSON data, do
//
//     final shiftModel = shiftModelFromJson(jsonString);

import 'dart:convert';

List<ShiftModel> shiftModelFromJson(String str) => List<ShiftModel>.from(json.decode(str).map((x) => ShiftModel.fromJson(x)));

String shiftModelToJson(List<ShiftModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShiftModel {
  String alias;
  String name;

  ShiftModel({
    required this.alias,
    required this.name,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) => ShiftModel(
    alias: json["alias"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "alias": alias,
    "name": name,
  };
}
