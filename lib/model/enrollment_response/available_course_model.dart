import 'dart:convert';

AvailableCourseModel availableCourseModelFromJson(String str) =>
    AvailableCourseModel.fromJson(json.decode(str));

String availableCourseModelToJson(AvailableCourseModel data) =>
    json.encode(data.toJson());

class AvailableCourseModel {
  final int code;
  final String message;
  final List<AvailableCourseDataList> availableCourseDataList;
  final DateTime requestedTime;

  AvailableCourseModel({
    required this.code,
    required this.message,
    required this.availableCourseDataList,
    required this.requestedTime,
  });

  factory AvailableCourseModel.fromJson(Map<String, dynamic> json) {
    try {
      return AvailableCourseModel(
        code: json["code"] ?? 0,
        message: json["message"] ?? "",
        availableCourseDataList: json["dataList"] != null
            ? List<AvailableCourseDataList>.from(
            json["dataList"].map((x) => AvailableCourseDataList.fromJson(x)))
            : [],
        requestedTime: DateTime.now(),
      );
    } catch (e) {
      print("Error parsing AvailableCourseModel: $e");
      return AvailableCourseModel(
        code: 0,
        message: "Parsing error",
        availableCourseDataList: [],
        requestedTime: DateTime.now(),
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "availableCourseDataList":
    List<dynamic>.from(availableCourseDataList.map((x) => x.toJson())),
    "requestedTime": requestedTime.toIso8601String(),
  };
}

class AvailableCourseDataList {
  final int id;
  final String uuid;
  final String title;
  final String description;
  final double fee;
  final int totalHour;
  final String? curriculumPdfUri;
  final Level level;
  final int totalLesson;
  final String thumbnailUri;
  final List<ClassOption> classOptions;
  final bool isActive;
  final List<CourseClass> classes;

  AvailableCourseDataList({
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
    this.isActive = true,
    required this.classes,
  });

  factory AvailableCourseDataList.fromJson(Map<String, dynamic> json) {
    try {
      return AvailableCourseDataList(
        id: json["id"] ?? 0,
        uuid: json["uuid"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        fee: (json["fee"] ?? 0).toDouble(),
        totalHour: json["totalHour"] ?? 0,
        curriculumPdfUri: json["curriculumPdfUri"],
        level: levelValues.map[json["level"]] ?? Level.BASIC,
        totalLesson: json["totalLesson"] ?? 0,
        thumbnailUri: json["thumbnailUri"] ?? "",
        classOptions: json["classOptions"] != null
            ? List<ClassOption>.from(
            json["classOptions"].map((x) => ClassOption.fromJson(x)))
            : [],
        isActive: json["isActive"] ?? true,
        classes: json["classes"] != null
            ? List<CourseClass>.from(
            json["classes"].map((x) => CourseClass.fromJson(x)))
            : [],
      );
    } catch (e) {
      print("Error parsing AvailableCourseDataList: $e");
      return AvailableCourseDataList(
        id: 0,
        uuid: "",
        title: "Unknown",
        description: "",
        fee: 0.0,
        totalHour: 0,
        level: Level.BASIC,
        totalLesson: 0,
        thumbnailUri: "",
        classOptions: [],
        classes: [],
      );
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
    "level": levelValues.reverse[level],
    "totalLesson": totalLesson,
    "thumbnailUri": thumbnailUri,
    "classOptions": List<dynamic>.from(classOptions.map((x) => x.toJson())),
    "isActive": isActive,
    "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
  };

  List<ClassOption> getAvailableClassOptions() {
    return classOptions.where((option) => option.hasAvailableSlots).toList();
  }

  AvailableCourseDataList copyWith({
    int? id,
    String? uuid,
    String? title,
    String? description,
    double? fee,
    int? totalHour,
    String? curriculumPdfUri,
    Level? level,
    int? totalLesson,
    String? thumbnailUri,
    List<ClassOption>? classOptions,
    bool? isActive,
    List<CourseClass>? classes,
  }) {
    return AvailableCourseDataList(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      description: description ?? this.description,
      fee: fee ?? this.fee,
      totalHour: totalHour ?? this.totalHour,
      curriculumPdfUri: curriculumPdfUri ?? this.curriculumPdfUri,
      level: level ?? this.level,
      totalLesson: totalLesson ?? this.totalLesson,
      thumbnailUri: thumbnailUri ?? this.thumbnailUri,
      classOptions: classOptions ?? List<ClassOption>.from(this.classOptions),
      isActive: isActive ?? this.isActive,
      classes: classes ?? List<CourseClass>.from(this.classes),
    );
  }
}

class CourseClass {
  final int id;
  final String shift;
  final String startTimeAsStr;
  final String endTimeAsStr;

  CourseClass({
    required this.id,
    required this.shift,
    required this.startTimeAsStr,
    required this.endTimeAsStr,
  });

  factory CourseClass.fromJson(Map<String, dynamic> json) {
    return CourseClass(
      id: json['id'] ?? 0,
      shift: json['shift'] ?? '',
      startTimeAsStr: json['startTimeAsStr'] ?? '',
      endTimeAsStr: json['endTimeAsStr'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'shift': shift,
    'startTimeAsStr': startTimeAsStr,
    'endTimeAsStr': endTimeAsStr,
  };
}

class ClassOption {
  final String title;
  final String timeRange;
  final int maxStudents;
  final int currentStudents;

  const ClassOption({
    required this.title,
    required this.timeRange,
    this.maxStudents = 30,
    this.currentStudents = 0,
  });

  factory ClassOption.fromJson(Map<String, dynamic> json) {
    try {
      return ClassOption(
        title: json["title"] ?? "",
        timeRange: json["timeRange"] ?? "",
        maxStudents: json["maxStudents"] ?? 30,
        currentStudents: json["currentStudents"] ?? 0,
      );
    } catch (e) {
      print("Error parsing ClassOption: $e");
      return ClassOption(title: "", timeRange: "");
    }
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "timeRange": timeRange,
    "maxStudents": maxStudents,
    "currentStudents": currentStudents,
  };

  bool get hasAvailableSlots => currentStudents < maxStudents;
}

enum Level { ADVANCED, BASIC, MEDIUM }

final levelValues = EnumValues({
  "Advanced": Level.ADVANCED,
  "Basic": Level.BASIC,
  "Medium": Level.MEDIUM,
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
