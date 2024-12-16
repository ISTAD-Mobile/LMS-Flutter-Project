import 'dart:convert';

JobVacancyResponse jobvacancyFromJson(String str) => JobVacancyResponse.fromJson(json.decode(str));
String jobvacancyToJson(JobVacancyResponse data) => json.encode(data.toJson());

class JobVacancyResponse {
  final int code;
  final String message;
  final List<JobVacancy> dataList;

  JobVacancyResponse({
    required this.code,
    required this.message,
    required this.dataList,
  });

  factory JobVacancyResponse.fromJson(Map<String, dynamic> json) {
    return JobVacancyResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? 'No message',
      dataList: (json['dataList'] as List?)
          ?.map((item) => JobVacancy.fromJson(item))
          .toList() ??
          [], // Handle null or missing `dataList`
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'dataList': dataList.map((item) => item.toJson()).toList(),
    };
  }
}

class JobVacancy {
  final int id;
  final String uuid;
  final String title;
  final String? description; // Nullable
  final String slug;
  final String? editorContent; // Nullable
  final String? thumbnail; // Nullable
  final List<String> images;
  final ContentType contentType;
  final List<int> tagIds;
  final int view;
  final String? publishedAt; // Nullable
  final String? publishedBy; // Nullable
  final String? updatedAt; // Nullable
  final String? updatedBy; // Nullable
  final bool isDeleted;
  final bool isDraft;

  JobVacancy({
    required this.id,
    required this.uuid,
    required this.title,
    this.description,
    required this.slug,
    this.editorContent,
    this.thumbnail,
    required this.images,
    required this.contentType,
    required this.tagIds,
    required this.view,
    this.publishedAt,
    this.publishedBy,
    this.updatedAt,
    this.updatedBy,
    required this.isDeleted,
    required this.isDraft,
  });

  factory JobVacancy.fromJson(Map<String, dynamic> json) {
    try {
      return JobVacancy(
        id: json['id'] ?? 0, // Provide default values
        uuid: json['uuid'] ?? '',
        title: json['title'] ?? 'Untitled',
        description: json['description'], // Allow null
        slug: json['slug'] ?? '',
        editorContent: json['editorContent'], // Allow null
        thumbnail: json['thumbnail'], // Allow null
        images: (json['images'] as List?)?.map((e) => e.toString()).toList() ??
            [], // Handle null
        contentType: ContentType.fromJson(json['contentType'] ?? {}),
        tagIds: (json['tagIds'] as List?)?.map((e) => e as int).toList() ?? [],
        view: json['view'] ?? 0,
        publishedAt: json['publishedAt'], // Allow null
        publishedBy: json['publishedBy'], // Allow null
        updatedAt: json['updatedAt'], // Allow null
        updatedBy: json['updatedBy'], // Allow null
        isDeleted: json['isDeleted'] ?? false,
        isDraft: json['isDraft'] ?? false,
      );
    } catch (e) {
      print('Error parsing JobVacancy: $e');
      throw FormatException('Invalid JSON format for JobVacancy');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'title': title,
      'description': description,
      'slug': slug,
      'editorContent': editorContent,
      'thumbnail': thumbnail,
      'images': images,
      'contentType': contentType.toJson(),
      'tagIds': tagIds,
      'view': view,
      'publishedAt': publishedAt,
      'publishedBy': publishedBy,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'isDeleted': isDeleted,
      'isDraft': isDraft,
    };
  }
}

class ContentType {
  final int id;
  final String type;

  ContentType({
    required this.id,
    required this.type,
  });

  factory ContentType.fromJson(Map<String, dynamic> json) {
    try {
      return ContentType(
        id: json['id'] ?? 0,
        type: json['type'] ?? 'Unknown',
      );
    } catch (e) {
      print('Error parsing ContentType: $e');
      throw FormatException('Invalid JSON format for ContentType');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
    };
  }
}
