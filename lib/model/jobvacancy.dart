import 'dart:convert';

JobvacancyResponse jobvacancyFromJson(String str) => JobvacancyResponse.fromJson(json.decode(str));
String jobvacancyToJson(JobvacancyResponse data) => json.encode(data.toJson());

class JobvacancyResponse {
  final int code;
  final String message;
  final List<Jobvacancy> jobvacancyList;
  final Paging paging;
  final DateTime? requestedTime;

  JobvacancyResponse({
    required this.code,
    required this.message,
    required this.jobvacancyList,
    required this.paging,
    this.requestedTime,
  });

  factory JobvacancyResponse.fromJson(Map<String, dynamic> json) => JobvacancyResponse(
    code: json["code"] ?? 0,
    message: json["message"] ?? "",
    jobvacancyList: (json['jobvacancyList'] as List)
        .map((item) => Jobvacancy.fromJson(item))
        .toList(),
    paging: Paging.fromJson(json["paging"] ?? {}),
    requestedTime: json["requestedTime"] == null
        ? null
        : DateTime.tryParse(json["requestedTime"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "jobvacancyList": jobvacancyList.map((course) => course.toJson()).toList(),
    "paging": paging.toJson(),
    "requestedTime": requestedTime?.toIso8601String(),
  };
}

class Jobvacancy {
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

  Jobvacancy({
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

  factory Jobvacancy.fromJson(Map<String, dynamic> json) => Jobvacancy(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    description: json["description"],
    slug: json["slug"] ,
    editorContent: json["editorContent"],
    thumbnail: json["thumbnail"],
    images: json["images"],
    contentType: ContentType.fromJson(json["contentType"]),
    tagIds: List<int>.from(json["tagIds"]),
    view: json["view"],
    publishedAt: json["publishedAt"],
    publishedBy: json["publishedBy"],
    updatedBy: json["updatedBy"],
    updatedAt: json["updatedAt"],
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
    "tagIds": tagIds,
    "view": view,
    "publishedAt": publishedAt,
    "publishedBy": publishedBy,
    "updatedAt": updatedAt,
    "updatedBy": updatedBy,
    "isDeleted": isDeleted,
    "isDraft": isDraft,
  };
}

class ContentType {
  int id;
  String type;

  ContentType({
    required this.id,
    required this.type,
  });

  factory ContentType.fromJson(Map<String, dynamic> json) => ContentType(
    id: json["id"] ?? 0,
    type: json["type"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}

class Paging {
  int page;
  int limit;
  int nextPage;
  int previousPage;
  int totalCount;
  int totalPages;
  int pagesToShow;
  int startPage;
  int endPage;
  int offset;

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
    page: json["page"] ?? 1,
    limit: json["limit"] ?? 10,
    nextPage: json["nextPage"] ?? 1,
    previousPage: json["previousPage"] ?? 1,
    totalCount: json["totalCount"] ?? 0,
    totalPages: json["totalPages"] ?? 1,
    pagesToShow: json["pagesToShow"] ?? 1,
    startPage: json["startPage"] ?? 1,
    endPage: json["endPage"] ?? 1,
    offset: json["offset"] ?? 0,
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

