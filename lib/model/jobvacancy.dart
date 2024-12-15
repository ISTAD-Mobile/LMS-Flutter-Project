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
    try {
      print('Parsing JobVacancyResponse: $json');
      return JobVacancyResponse(
        code: json['code'] ?? 0,
        message: json['message'] ?? 'No message',
        dataList: json['dataList'] != null
            ? List<JobVacancy>.from(json['dataList'].map((x) => JobVacancy.fromJson(x)))
            : [],
      );
    } catch (e) {
      print('Error parsing JobVacancyResponse: $e');
      print('Error JSON: $json');
      throw FormatException('Invalid JSON format for JobVacancyResponse');
    }
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
  final String? description;
  final String slug;
  final String editorContent;
  final String thumbnail;
  final List<String>? images;
  final ContentType contentType;
  final List<int> tagIds;
  final int view;
  final String publishedAt;
  final String publishedBy;
  final String? updatedAt;
  final String? updatedBy;
  final bool? isDeleted;
  final bool? isDraft;

  JobVacancy({
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

  factory JobVacancy.fromJson(Map<String, dynamic> json) {
    try {
      return JobVacancy(
        id: json['id'] ?? 0,
        uuid: json['uuid'] ?? '',
        title: json['title'] ?? '',
        description: json['description'],
        slug: json['slug'] ?? '',
        editorContent: json['editorContent'] ?? '',
        thumbnail: json['thumbnail'] ?? '',
        images: json['images'] != null
            ? List<String>.from(json['images'] as List)
            : null,
        contentType: json['contentType'] != null
            ? ContentType.fromJson(json['contentType'])
            : ContentType(id: 0, type: 'Unknown'),
        tagIds: List<int>.from(json['tagIds'] ?? []),
        view: json['view'] ?? 0,
        publishedAt: json['publishedAt'] ?? '',
        publishedBy: json['publishedBy'] ?? '',
        updatedAt: json['updatedAt'],
        updatedBy: json['updatedBy'],
        isDeleted: json['isDeleted'],
        isDraft: json['isDraft'],
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
        type: json['type'] ?? '',
      );
    } catch (e) {
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

