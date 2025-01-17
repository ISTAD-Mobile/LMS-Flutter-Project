import 'dart:convert';

/// Convert JSON to JobvacancyResponse
JobvacancyResponse jobvacancyResponseFromJson(String str) =>
    JobvacancyResponse.fromJson(json.decode(str));

/// Convert JobvacancyResponse to JSON
String jobvacancyResponseToJson(JobvacancyResponse data) =>
    json.encode(data.toJson());

class JobvacancyResponse {
  final int code;
  final String message;
  final List<JobvacancyDataList> data;
  final Paging paging;
  final DateTime requestedTime;

  JobvacancyResponse({
    required this.code,
    required this.message,
    required this.data,
    required this.paging,
    required this.requestedTime,
  });

  factory JobvacancyResponse.fromJson(Map<String, dynamic> json) => JobvacancyResponse(
    code: json["code"],
    message: json["message"],
    data: List<JobvacancyDataList>.from(
        json["dataList"].map((x) => JobvacancyDataList.fromJson(x))),
    paging: Paging.fromJson(json["paging"]),
    requestedTime: DateTime.parse(json["requestedTime"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "dataList": List<dynamic>.from(data.map((x) => x.toJson())),
    "paging": paging.toJson(),
    "requestedTime": requestedTime.toIso8601String(),
  };
}

class JobvacancyDataList {
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

  JobvacancyDataList({
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

  factory JobvacancyDataList.fromJson(Map<String, dynamic> json) => JobvacancyDataList(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    description: json["description"],
    slug: json["slug"],
    editorContent: json["editorContent"],
    thumbnail: json["thumbnail"],
    images: json["images"],
    contentType: ContentType.fromJson(json["contentType"]),
    tagIds: List<int>.from(json["tagIds"].map((x) => x)),
    view: json["view"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    publishedBy: json["publishedBy"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.tryParse(json["updatedAt"]),
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
    id: json["id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}

class Paging {
  final int page;
  final int limit;
  final int nextPage;
  final int previousPage;
  final int totalCount;
  final int totalPages;
  final int pagesToShow;
  final int startPage;
  final int endPage;
  final int offset;

  Paging({
    required this.page,
    required this.limit,
    required this.nextPage,
    required this.previousPage,
    required this.totalCount,
    required this.totalPages,
    required this.pagesToShow,
    required this.startPage,
    required this.endPage,
    required this.offset,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    page: json["page"],
    limit: json["limit"],
    nextPage: json["nextPage"],
    previousPage: json["previousPage"],
    totalCount: json["totalCount"],
    totalPages: json["totalPages"],
    pagesToShow: json["pagesToShow"],
    startPage: json["startPage"],
    endPage: json["endPage"],
    offset: json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "nextPage": nextPage,
    "previousPage": previousPage,
    "totalCount": totalCount,
    "totalPages": totalPages,
    "pagesToShow": pagesToShow,
    "startPage": startPage,
    "endPage": endPage,
    "offset": offset,
  };
}
