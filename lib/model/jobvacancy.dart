// To parse this JSON data, do
//
//     final jobvacancyResponse = jobvacancyResponseFromJson(jsonString);

import 'dart:convert';

JobvacancyResponse jobvacancyResponseFromJson(String str) => JobvacancyResponse.fromJson(json.decode(str));

String jobvacancyResponseToJson(JobvacancyResponse data) => json.encode(data.toJson());

class JobvacancyResponse {
  int? code;
  String? message;
  List<DataList>? dataList;
  Map<String, int>? paging;
  DateTime? requestedTime;

  JobvacancyResponse({
    this.code,
    this.message,
    this.dataList,
    this.paging,
    this.requestedTime,
  });

  factory JobvacancyResponse.fromJson(Map<String, dynamic> json) => JobvacancyResponse(
    code: json["code"],
    message: json["message"],
    dataList: json["dataList"] == null ? [] : List<DataList>.from(json["dataList"]!.map((x) => DataList.fromJson(x))),
    paging: Map.from(json["paging"]!).map((k, v) => MapEntry<String, int>(k, v)),
    requestedTime: json["requestedTime"] == null ? null : DateTime.parse(json["requestedTime"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "dataList": dataList == null ? [] : List<dynamic>.from(dataList!.map((x) => x.toJson())),
    "paging": Map.from(paging!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "requestedTime": requestedTime?.toIso8601String(),
  };
}

class DataList {
  int? id;
  String? uuid;
  String? title;
  dynamic description;
  String? slug;
  String? editorContent;
  String? thumbnail;
  dynamic images;
  ContentType? contentType;
  List<int>? tagIds;
  int? view;
  DateTime? publishedAt;
  PublishedBy? publishedBy;
  dynamic updatedAt;
  dynamic updatedBy;
  dynamic isDeleted;
  dynamic isDraft;

  DataList({
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

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
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
    publishedBy: publishedByValues.map[json["publishedBy"]]!,
    updatedAt: json["updatedAt"],
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
    "publishedBy": publishedByValues.reverse[publishedBy],
    "updatedAt": updatedAt,
    "updatedBy": updatedBy,
    "isDeleted": isDeleted,
    "isDraft": isDraft,
  };
}

class ContentType {
  int? id;
  Type? type;

  ContentType({
    this.id,
    this.type,
  });

  factory ContentType.fromJson(Map<String, dynamic> json) => ContentType(
    id: json["id"],
    type: typeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": typeValues.reverse[type],
  };
}

enum Type {
  BLOG,
  JOB_ANNOUNCEMENT
}

final typeValues = EnumValues({
  "Blog": Type.BLOG,
  "Job Announcement": Type.JOB_ANNOUNCEMENT
});

enum PublishedBy {
  BOSS
}

final publishedByValues = EnumValues({
  "boss": PublishedBy.BOSS
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
