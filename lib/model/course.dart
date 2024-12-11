import 'dart:convert';

CourseResponse courseFromJson(String str) => CourseResponse.fromJson(json.decode(str));

String courseToJson(CourseResponse data) => json.encode(data.toJson());

class CourseResponse {
  final int code;
  final String message;
  final List<Course> dataList;

  CourseResponse({
    required this.code,
    required this.message,
    required this.dataList,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      code: json['code'],
      message: json['message'],
      dataList: (json['dataList'] as List)
          .map((item) => Course.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'dataList': dataList.map((course) => course.toJson()).toList(),
    };
  }
}

class Course {
  final int id;
  final String uuid;
  final String title;
  final String description;
  final double fee;
  final int totalHour;
  final String? curriculumPdfUri;
  final String level;
  final int totalLesson;
  final String thumbnailUri;

  Course({
    required this.id,
    required this.uuid,
    required this.title,
    required this.description,
    required this.fee,
    required this.totalHour,
    this.curriculumPdfUri,
    required this.level,
    required this.totalLesson,
    required this.thumbnailUri,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      uuid: json['uuid'],
      title: json['title'],
      description: json['description'],
      fee: (json['fee'] as num).toDouble(),
      totalHour: json['totalHour'],
      curriculumPdfUri: json['curriculumPdfUri'],
      level: json['level'],
      totalLesson: json['totalLesson'],
      thumbnailUri: json['thumbnailUri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'title': title,
      'description': description,
      'fee': fee,
      'totalHour': totalHour,
      'curriculumPdfUri': curriculumPdfUri,
      'level': level,
      'totalLesson': totalLesson,
      'thumbnailUri': thumbnailUri,
    };
  }
}
