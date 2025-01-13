import 'dart:convert';

CourseResponse courseFromJson(String str) => CourseResponse.fromJson(json.decode(str));

String courseToJson(CourseResponse data) => json.encode(data.toJson());

class CourseResponse {
  final int code;
  final String message;
  final List<Course> courseList;

  CourseResponse({
    required this.code,
    required this.message,
    required this.courseList,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      code: json['code'] ?? 0,  // Default to 0 if 'code' is missing
      message: json['message'] ?? 'Unknown error', // Default message if 'message' is missing
      courseList: (json['dataList'] as List?)
          ?.map((item) => Course.fromJson(item))
          .toList() ??
          [],  // Ensure we return an empty list if 'dataList' is null or invalid
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'dataList': courseList.map((course) => course.toJson()).toList(),
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
  final List<ClassOption> classOptions;

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
    required this.classOptions,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    var optionsList = (json['classOptions'] as List?)
        ?.map((item) => ClassOption.fromJson(item))
        .toList() ??
        [];  // Ensure we return an empty list if 'classOptions' is null or invalid

    return Course(
      id: json['id'] ?? 0, // Default to 0 if 'id' is missing
      uuid: json['uuid'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      fee: (json['fee'] as num?)?.toDouble() ?? 0.0, // Safely cast fee to double
      totalHour: json['totalHour'] ?? 0, // Default to 0 if 'totalHour' is missing
      curriculumPdfUri: json['curriculumPdfUri'],
      level: json['level'] ?? '',
      totalLesson: json['totalLesson'] ?? 0, // Default to 0 if 'totalLesson' is missing
      thumbnailUri: json['thumbnailUri'] ?? '',
      classOptions: optionsList,
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
      'classOptions': classOptions.map((option) => option.toJson()).toList(),
    };
  }
}

class ClassOption {
  final String title;
  final String timeRange;

  ClassOption({
    required this.title,
    required this.timeRange,
  });

  factory ClassOption.fromJson(Map<String, dynamic> json) {
    return ClassOption(
      title: json['title'] ?? '',
      timeRange: json['timeRange'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'timeRange': timeRange,
    };
  }
}