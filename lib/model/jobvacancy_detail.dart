// To parse this JSON data, do
//
//     final jobvacancyDetailModel = jobvacancyDetailModelFromJson(jsonString);

import 'dart:convert';

JobvacancyDetailModel jobvacancyDetailModelFromJson(String str) => JobvacancyDetailModel.fromJson(json.decode(str));

String jobvacancyDetailModelToJson(JobvacancyDetailModel data) => json.encode(data.toJson());

class JobvacancyDetailModel {
  int? code;
  String? message;
  Data? data;
  DateTime? requestedTime;

  JobvacancyDetailModel({
    this.code,
    this.message,
    this.data,
    this.requestedTime,
  });

  factory JobvacancyDetailModel.fromJson(Map<String, dynamic> json) => JobvacancyDetailModel(
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    requestedTime: json["requestedTime"] == null ? null : DateTime.parse(json["requestedTime"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
    "requestedTime": requestedTime?.toIso8601String(),
  };
}

class Data {
  int? id;
  String? uuid;
  String? title;
  String? description;
  String? slug;
  String? editorContent;
  String? thumbnail;
  dynamic images;
  ContentType? contentType;
  List<int>? tagIds;
  int? view;
  DateTime? publishedAt;
  String? publishedBy;
  DateTime? updatedAt;
  String? updatedBy;
  bool? isDeleted;
  dynamic isDraft;

  Data({
    this.id,
    this.uuid,
    this.title,
    this.description,
    this.slug,
    this.editorContent,
    this.thumbnail,
    this.images,
    this.contentType,
    this.tagIds,
    this.view,
    this.publishedAt,
    this.publishedBy,
    this.updatedAt,
    this.updatedBy,
    this.isDeleted,
    this.isDraft,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    description: json["description"],
    slug: json["slug"],
    editorContent: json["editorContent"],
    thumbnail: json["thumbnail"],
    images: json["images"],
    contentType: json["contentType"] == null ? null : ContentType.fromJson(json["contentType"]),
    tagIds: json["tagIds"] == null ? [] : List<int>.from(json["tagIds"]!.map((x) => x)),
    view: json["view"],
    publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
    publishedBy: json["publishedBy"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    updatedBy: json["updatedBy"],
    isDeleted: json["isDeleted"],
    isDraft: json["isDraft"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "description": description,
    "slug": slug,
    "editorContent": editorContent,
    "thumbnail": thumbnail,
    "images": images,
    "contentType": contentType?.toJson(),
    "tagIds": tagIds == null ? [] : List<dynamic>.from(tagIds!.map((x) => x)),
    "view": view,
    "publishedAt": publishedAt?.toIso8601String(),
    "publishedBy": publishedBy,
    "updatedAt": updatedAt?.toIso8601String(),
    "updatedBy": updatedBy,
    "isDeleted": isDeleted,
    "isDraft": isDraft,
  };
}

class ContentType {
  int? id;
  String? type;

  ContentType({
    this.id,
    this.type,
  });

  factory ContentType.fromJson(Map<String, dynamic> json) => ContentType(
    id: json["id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}
