import 'dart:convert';

AvailableCourseDetailModel availableCourseDetailModelFromJson(String str) =>
    AvailableCourseDetailModel.fromJson(json.decode(str));

String availableCourseDetailModelToJson(AvailableCourseDetailModel data) =>
    json.encode(data.toJson());

class AvailableCourseDetailModel {
  int code;
  String message;
  Data data;
  DateTime requestedTime;

  AvailableCourseDetailModel({
    required this.code,
    required this.message,
    required this.data,
    required this.requestedTime,
  });

  factory AvailableCourseDetailModel.fromJson(Map<String, dynamic> json) {
    try {
      return AvailableCourseDetailModel(
        code: json["code"]?.toInt() ?? 0,
        message: json["message"]?.toString() ?? "",
        data: Data.fromJson(json["data"] ?? {}),
        requestedTime: DateTime.tryParse(json["requestedTime"]?.toString() ?? "") ?? DateTime.now(),
      );
    } catch (e) {
      print("Error parsing AvailableCourseDetailModel: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
    "requestedTime": requestedTime.toIso8601String(),
  };
}

class Data {
  int id;
  String uuid;
  String title;
  String description;
  double fee;
  String? curriculumPdfUri;
  String? thumbnailUri;
  int totalHour;
  String level;
  int totalLesson;
  List<Class> classes;
  Offer offer;
  List<Detail> details;
  List<Detail> outline;

  Data({
    required this.id,
    required this.uuid,
    required this.title,
    required this.description,
    required this.fee,
    this.curriculumPdfUri,
    this.thumbnailUri,
    required this.totalHour,
    required this.level,
    required this.totalLesson,
    required this.classes,
    required this.offer,
    required this.details,
    required this.outline,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    try {
      return Data(
        id: json["id"]?.toInt() ?? 0,
        uuid: json["uuid"]?.toString() ?? "",
        title: json["title"]?.toString() ?? "",
        description: json["description"]?.toString() ?? "",
        fee: (json["fee"] is int)
            ? (json["fee"] as int).toDouble()
            : (json["fee"] as num?)?.toDouble() ?? 0.0,
        curriculumPdfUri: json["curriculumPdfUri"]?.toString(),
        thumbnailUri: json["thumbnailUri"]?.toString(),
        totalHour: json["totalHour"]?.toInt() ?? 0,
        level: json["level"]?.toString() ?? "",
        totalLesson: json["totalLesson"]?.toInt() ?? 0,
        classes: List<Class>.from((json["classes"] ?? []).map((x) => Class.fromJson(x))),
        offer: Offer.fromJson(json["offer"] ?? {}),
        details: List<Detail>.from((json["details"] ?? []).map((x) => Detail.fromJson(x))),
        outline: List<Detail>.from((json["outline"] ?? []).map((x) => Detail.fromJson(x))),
      );
    } catch (e) {
      print("Error parsing Data: $e");
      rethrow;
    }
  }

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
    "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
    "offer": offer.toJson(),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "outline": List<dynamic>.from(outline.map((x) => x.toJson())),
  };
}

class Class {
  int id;
  String uuid;
  String code;
  String? room;        // Made nullable
  String shift;
  String startTimeAsStr;
  String endTimeAsStr;
  Course course;
  String? instructorUuid;  // Made nullable
  dynamic telegramGroup;
  bool isWeekend;

  Class({
    required this.id,
    required this.uuid,
    required this.code,
    this.room,
    required this.shift,
    required this.startTimeAsStr,
    required this.endTimeAsStr,
    required this.course,
    this.instructorUuid,
    this.telegramGroup,
    required this.isWeekend,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    try {
      return Class(
        id: json["id"]?.toInt() ?? 0,
        uuid: json["uuid"]?.toString() ?? "",
        code: json["code"]?.toString() ?? "",
        room: json["room"]?.toString(),
        shift: json["shift"]?.toString() ?? "",
        startTimeAsStr: json["startTimeAsStr"]?.toString() ?? "",
        endTimeAsStr: json["endTimeAsStr"]?.toString() ?? "",
        course: Course.fromJson(json["course"] ?? {}),
        instructorUuid: json["instructorUuid"]?.toString(),
        telegramGroup: json["telegramGroup"],
        isWeekend: json["isWeekend"] ?? false,
      );
    } catch (e) {
      print("Error parsing Class: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "code": code,
    "room": room,
    "shift": shift,
    "startTimeAsStr": startTimeAsStr,
    "endTimeAsStr": endTimeAsStr,
    "course": course.toJson(),
    "instructorUuid": instructorUuid,
    "telegramGroup": telegramGroup,
    "isWeekend": isWeekend,
  };
}

class Course {
  int id;
  String uuid;
  String title;
  String description;
  double fee;
  int totalHour;
  String? curriculumPdfUri;
  String level;
  int totalLesson;
  String? thumbnailUri;

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
    this.thumbnailUri,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    try {
      return Course(
        id: json["id"]?.toInt() ?? 0,
        uuid: json["uuid"]?.toString() ?? "",
        title: json["title"]?.toString() ?? "",
        description: json["description"]?.toString() ?? "",
        fee: (json["fee"] is int)
            ? (json["fee"] as int).toDouble()
            : (json["fee"] as num?)?.toDouble() ?? 0.0,
        totalHour: json["totalHour"]?.toInt() ?? 0,
        curriculumPdfUri: json["curriculumPdfUri"]?.toString(),
        level: json["level"]?.toString() ?? "",
        totalLesson: json["totalLesson"]?.toInt() ?? 0,
        thumbnailUri: json["thumbnailUri"]?.toString(),
      );
    } catch (e) {
      print("Error parsing Course: $e");
      rethrow;
    }
  }

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
  String code;
  int order;
  String title;
  List<String> details;

  Detail({
    required this.code,
    required this.order,
    required this.title,
    required this.details,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    try {
      return Detail(
        code: json["code"]?.toString() ?? "",
        order: json["order"]?.toInt() ?? 0,
        title: json["title"]?.toString() ?? "",
        details: List<String>.from((json["details"] ?? []).map((x) => x.toString())),
      );
    } catch (e) {
      print("Error parsing Detail: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "order": order,
    "title": title,
    "details": List<dynamic>.from(details.map((x) => x)),
  };
}

class Offer {
  List<String> details;

  Offer({
    required this.details,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    try {
      return Offer(
        details: List<String>.from((json["details"] ?? []).map((x) => x.toString())),
      );
    } catch (e) {
      print("Error parsing Offer: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    "details": List<dynamic>.from(details.map((x) => x)),
  };
}
