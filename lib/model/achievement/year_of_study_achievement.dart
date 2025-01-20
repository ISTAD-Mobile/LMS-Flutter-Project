// To parse this JSON data, do
//
//     final yearOfStudyAchievementModel = yearOfStudyAchievementModelFromJson(jsonString);

import 'dart:convert';

YearOfStudyAchievementModel yearOfStudyAchievementModelFromJson(String str) => YearOfStudyAchievementModel.fromJson(json.decode(str));

String yearOfStudyAchievementModelToJson(YearOfStudyAchievementModel data) => json.encode(data.toJson());

class YearOfStudyAchievementModel {
  List<YearOfStudyList> yearOfStudy;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  bool first;
  int numberOfElements;
  int size;
  int number;
  Sort sort;
  bool empty;

  YearOfStudyAchievementModel({
    required this.yearOfStudy,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.first,
    required this.numberOfElements,
    required this.size,
    required this.number,
    required this.sort,
    required this.empty,
  });

  factory YearOfStudyAchievementModel.fromJson(Map<String, dynamic> json) => YearOfStudyAchievementModel(
    yearOfStudy: List<YearOfStudyList>.from(json["content"].map((x) => YearOfStudyList.fromJson(x))),
    pageable: Pageable.fromJson(json["pageable"]),
    totalPages: json["totalPages"],
    totalElements: json["totalElements"],
    last: json["last"],
    first: json["first"],
    numberOfElements: json["numberOfElements"],
    size: json["size"],
    number: json["number"],
    sort: Sort.fromJson(json["sort"]),
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(yearOfStudy.map((x) => x.toJson())),
    "pageable": pageable.toJson(),
    "totalPages": totalPages,
    "totalElements": totalElements,
    "last": last,
    "first": first,
    "numberOfElements": numberOfElements,
    "size": size,
    "number": number,
    "sort": sort.toJson(),
    "empty": empty,
  };
}

class YearOfStudyList {
  int year;
  int semester;
  List<CourseList> courseList;

  YearOfStudyList({
    required this.year,
    required this.semester,
    required this.courseList,
  });

  factory YearOfStudyList.fromJson(Map<String, dynamic> json) => YearOfStudyList(
    year: json["year"],
    semester: json["semester"],
    courseList: List<CourseList>.from(json["course"].map((x) => CourseList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "semester": semester,
    "course": List<dynamic>.from(courseList.map((x) => x.toJson())),
  };
}

class CourseList {
  String title;
  int score;
  int credit;
  String grade;

  CourseList({
    required this.title,
    required this.score,
    required this.credit,
    required this.grade,
  });

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
    title: json["title"],
    score: json["score"],
    credit: json["credit"],
    grade: json["grade"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "score": score,
    "credit": credit,
    "grade": grade,
  };
}

class Pageable {
  int pageNumber;
  int pageSize;
  Sort sort;
  int offset;
  bool unpaged;
  bool paged;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.unpaged,
    required this.paged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    sort: Sort.fromJson(json["sort"]),
    offset: json["offset"],
    unpaged: json["unpaged"],
    paged: json["paged"],
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "sort": sort.toJson(),
    "offset": offset,
    "unpaged": unpaged,
    "paged": paged,
  };
}

class Sort {
  bool unsorted;
  bool sorted;
  bool empty;

  Sort({
    required this.unsorted,
    required this.sorted,
    required this.empty,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
    unsorted: json["unsorted"],
    sorted: json["sorted"],
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "unsorted": unsorted,
    "sorted": sorted,
    "empty": empty,
  };
}
