import 'dart:convert';

JobvacancyResponse jobvacancyResponseFromJson(String str) =>
    JobvacancyResponse.fromJson(json.decode(str));

String jobvacancyResponseToJson(JobvacancyResponse data) =>
    json.encode(data.toJson());

class JobvacancyResponse {
  final int code;
  final String message;
  final List<DataList> dataList;
  final Map<String, int>? paging;
  final DateTime? requestedTime;

  JobvacancyResponse({
    required this.code,
    required this.message,
    required this.dataList,
    this.paging,
    this.requestedTime,
  });

  factory JobvacancyResponse.fromJson(Map<String, dynamic> json) =>
      JobvacancyResponse(
        code: json["code"] ?? 0,
        message: json["message"] ?? "No message provided",
        dataList: json["dataList"] == null
            ? []
            : List<DataList>.from(
            json["dataList"].map((x) => DataList.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : Map<String, int>.from(json["paging"]),
        requestedTime: json["requestedTime"] == null
            ? null
            : DateTime.tryParse(json["requestedTime"]),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "dataList": List<dynamic>.from(dataList.map((x) => x.toJson())),
    "paging": paging,
    "requestedTime": requestedTime?.toIso8601String(),
  };
}

class DataList {
  final int id;
  final String uuid;
  final String title;
  final String? description;
  final String slug;
  final String editorContent;
  final String thumbnail;
  final String? images;
  final ContentType contentType;
  final List<int> tagIds;
  final int view;
  final DateTime publishedAt;
  final String publishedBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final bool? isDeleted;
  final bool? isDraft;

  DataList({
    required this.id,
    required this.uuid,
    required this.title,
    this.description,
    required this.slug,
    required this.editorContent,
    required this.thumbnail,
    this.images,
    required this.contentType,
    required this.tagIds,
    required this.view,
    required this.publishedAt,
    required this.publishedBy,
    this.updatedAt,
    this.updatedBy,
    this.isDeleted,
    this.isDraft,
  });

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
    id: json["id"] ?? 0,
    uuid: json["uuid"] ?? "",
    title: json["title"] ?? "Untitled",
    description: json["description"],
    slug: json["slug"] ?? "",
    editorContent: json["editorContent"] ?? "",
    thumbnail: json["thumbnail"] ?? "",
    images: json["images"],
    contentType: ContentType.fromJson(json["contentType"]),
    tagIds: json["tagIds"] == null
        ? []
        : List<int>.from(json["tagIds"].map((x) => x)),
    view: json["view"] ?? 0,
    publishedAt: DateTime.parse(json["publishedAt"]),
    publishedBy: json["publishedBy"] ?? "Unknown",
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.tryParse(json["updatedAt"]),
    updatedBy: json["updatedBy"],
    isDeleted: json["isDeleted"] == null
        ? null
        : json["isDeleted"] as bool,
    isDraft: json["isDraft"] == null ? null : json["isDraft"] as bool,
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
    "contentType": contentType.toJson(),
    "tagIds": List<dynamic>.from(tagIds.map((x) => x)),
    "view": view,
    "publishedAt": publishedAt.toIso8601String(),
    "publishedBy": publishedBy,
    "updatedAt": updatedAt?.toIso8601String(),
    "updatedBy": updatedBy,
    "isDeleted": isDeleted,
    "isDraft": isDraft,
  };
}

class ContentType {
  final int id;
  final String type;

  ContentType({
    required this.id,
    required this.type,
  });

  factory ContentType.fromJson(Map<String, dynamic> json) => ContentType(
    id: json["id"] ?? 0,
    type: json["type"] ?? "Unknown Type",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}
