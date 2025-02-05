
import 'dart:convert';

CourseDetailResponse courseDetailResponseFromJson(String str) =>
    CourseDetailResponse.fromJson(json.decode(str));

String courseDetailResponseToJson(CourseDetailResponse data) =>
    json.encode(data.toJson());

class CourseDetailResponse {
  int? code;
  String? message;
  Data? data;
  DateTime? requestedTime;

  CourseDetailResponse({
    this.code,
    this.message,
    this.data,
    this.requestedTime,
  });

  factory CourseDetailResponse.fromJson(Map<String, dynamic> json) =>
      CourseDetailResponse(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        requestedTime: json["requestedTime"] == null
            ? null
            : DateTime.parse(json["requestedTime"]),
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
  double? fee;
  dynamic curriculumPdfUri;
  String? thumbnailUri;
  int? totalHour;
  String? level;
  int? totalLesson;
  List<Class>? classes;
  Offer? offer;
  List<Detail>? details;
  List<Detail>? outline;

  Data({
    this.id,
    this.uuid,
    this.title,
    this.description,
    this.fee,
    this.curriculumPdfUri,
    this.thumbnailUri,
    this.totalHour,
    this.level,
    this.totalLesson,
    this.classes,
    this.offer,
    this.details,
    this.outline,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    description: json["description"],
    fee: (json["fee"] is double)
        ? json["fee"]
        : (json["fee"] as num?)?.toDouble(),
    curriculumPdfUri: json["curriculumPdfUri"],
    thumbnailUri: json["thumbnailUri"],
    totalHour: json["totalHour"],
    level: json["level"],
    totalLesson: json["totalLesson"],
    classes: json["classes"] == null
        ? []
        : List<Class>.from(json["classes"]!.map((x) => Class.fromJson(x))),
    offer:
    json["offer"] == null ? null : Offer.fromJson(json["offer"]),
    details: json["details"] == null
        ? []
        : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
    outline: json["outline"] == null
        ? []
        : List<Detail>.from(json["outline"]!.map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "description": description,
    "fee": fee,
    "curriculumPdfUri": curriculumPdfUri,
    "thumbnailUri": thumbnailUri,
    "totalHour": totalHour,
    "level": level,
    "totalLesson": totalLesson,
    "classes": classes == null
        ? []
        : List<dynamic>.from(classes!.map((x) => x.toJson())),
    "offer": offer?.toJson(),
    "details": details == null
        ? []
        : List<dynamic>.from(details!.map((x) => x.toJson())),
    "outline": outline == null
        ? []
        : List<dynamic>.from(outline!.map((x) => x.toJson())),
  };
}

class Class {
  int? id;
  String? uuid;
  String? code;
  String? room;
  String? shift;
  String? startTimeAsStr;
  String? endTimeAsStr;
  Course? course;
  String? instructorUuid;
  dynamic telegramGroup;
  bool? isWeekend;

  Class({
    this.id,
    this.uuid,
    this.code,
    this.room,
    this.shift,
    this.startTimeAsStr,
    this.endTimeAsStr,
    this.course,
    this.instructorUuid,
    this.telegramGroup,
    this.isWeekend,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    id: json["id"],
    uuid: json["uuid"],
    code: json["code"],
    room: json["room"],
    shift: json["shift"],
    startTimeAsStr: json["startTimeAsStr"],
    endTimeAsStr: json["endTimeAsStr"],
    course: json["course"] == null ? null : Course.fromJson(json["course"]),
    instructorUuid: json["instructorUuid"],
    telegramGroup: json["telegramGroup"],
    isWeekend: json["isWeekend"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "code": code,
    "room": room,
    "shift": shift,
    "startTimeAsStr": startTimeAsStr,
    "endTimeAsStr": endTimeAsStr,
    "course": course?.toJson(),
    "instructorUuid": instructorUuid,
    "telegramGroup": telegramGroup,
    "isWeekend": isWeekend,
  };
}

class Course {
  int? id;
  String? uuid;
  String? title;
  String? description;
  double? fee;  // Changed from int? to double?
  int? totalHour;
  dynamic curriculumPdfUri;
  String? level;
  int? totalLesson;
  dynamic thumbnailUri;

  Course({
    this.id,
    this.uuid,
    this.title,
    this.description,
    this.fee,
    this.totalHour,
    this.curriculumPdfUri,
    this.level,
    this.totalLesson,
    this.thumbnailUri,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    description: json["description"],
    fee: json["fee"] is double ? json["fee"] : (json["fee"] as num?)?.toDouble(),  // Ensure fee is treated as double
    totalHour: json["totalHour"],
    curriculumPdfUri: json["curriculumPdfUri"],
    level: json["level"],
    totalLesson: json["totalLesson"],
    thumbnailUri: json["thumbnailUri"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "description": description,
    "fee": fee,
    "totalHour": totalHour,
    "curriculumPdfUri": curriculumPdfUri,
    "level": level,
    "totalLesson": totalLesson,
    "thumbnailUri": thumbnailUri,
  };
}

class Detail {
  String? code;
  int? order;
  String? title;
  List<String>? details;

  Detail({
    this.code,
    this.order,
    this.title,
    this.details,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    code: json["code"],
    order: json["order"],
    title: json["title"],
    details: json["details"] == null
        ? []
        : List<String>.from(json["details"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "order": order,
    "title": title,
    "details": details == null
        ? []
        : List<dynamic>.from(details!.map((x) => x)),
  };
}

class Offer {
  List<String>? details;

  Offer({
    this.details,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    details: json["details"] == null
        ? []
        : List<String>.from(json["details"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "details": details == null
        ? []
        : List<dynamic>.from(details!.map((x) => x)),
  };
}
