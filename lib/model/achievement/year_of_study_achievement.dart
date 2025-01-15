// import 'dart:convert';
//
// class YearOfStudyAchievement {
//   List<Content>? content;
//
//   YearOfStudyAchievement({
//     this.content,
//   });
//
//   factory YearOfStudyAchievement.fromJson(Map<String, dynamic> json) {
//     return YearOfStudyAchievement(
//       content: json["content"] == null
//           ? []
//           : List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "content": content == null
//           ? []
//           : List<dynamic>.from(content!.map((x) => x.toJson())),
//     };
//   }
// }
//
// class Content {
//   int? year;
//   int? semester;
//   List<Course>? course;
//
//   Content({
//     this.year,
//     this.semester,
//     this.course,
//   });
//
//   factory Content.fromJson(Map<String, dynamic> json) {
//     return Content(
//       year: json["year"],
//       semester: json["semester"],
//       course: json["course"] == null
//           ? []
//           : List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "year": year,
//       "semester": semester,
//       "course": course == null
//           ? []
//           : List<dynamic>.from(course!.map((x) => x.toJson())),
//     };
//   }
// }
//
// class Course {
//   String? title;
//   int? score;
//   int? credit;
//   String? grade;
//
//   Course({
//     this.title,
//     this.score,
//     this.credit,
//     this.grade,
//   });
//
//   factory Course.fromJson(Map<String, dynamic> json) {
//     return Course(
//       title: json["title"],
//       score: json["score"],
//       credit: json["credit"],
//       grade: json["grade"],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "title": title,
//       "score": score,
//       "credit": credit,
//       "grade": grade,
//     };
//   }
// }



// import 'dart:convert';
//
// class YearOfStudyAchievement {
//   List<Content>? content;
//
//   YearOfStudyAchievement({this.content});
//
//   factory YearOfStudyAchievement.fromJson(Map<String, dynamic> json) {
//     return YearOfStudyAchievement(
//       content: json["content"] == null
//           ? []
//           : List<Content>.from(
//           json["content"].map((x) => Content.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "content": content == null
//           ? []
//           : List<dynamic>.from(content!.map((x) => x.toJson())),
//     };
//   }
// }
//
// class Content {
//   int? year;
//   int? semester;
//   List<Course>? course;
//
//   Content({
//     this.year,
//     this.semester,
//     this.course,
//   });
//
//   factory Content.fromJson(Map<String, dynamic> json) {
//     return Content(
//       year: json["year"],
//       semester: json["semester"],
//       course: json["course"] == null
//           ? []
//           : List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "year": year,
//       "semester": semester,
//       "course": course == null
//           ? []
//           : List<dynamic>.from(course!.map((x) => x.toJson())),
//     };
//   }
// }
//
// class Course {
//   String? title;
//   int? score;
//   int? credit;
//   String? grade;
//
//   Course({
//     this.title,
//     this.score,
//     this.credit,
//     this.grade,
//   });
//
//   factory Course.fromJson(Map<String, dynamic> json) {
//     return Course(
//       title: json["title"],
//       score: json["score"],
//       credit: json["credit"],
//       grade: json["grade"],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "title": title,
//       "score": score,
//       "credit": credit,
//       "grade": grade,
//     };
//   }
// }





import 'dart:convert';

YearOfStudyAchievementModel yearOfStudyAchievementModelFromJson(String str) => YearOfStudyAchievementModel.fromJson(json.decode(str));
String yearOfStudyAchievementModelToJson(YearOfStudyAchievementModel data) => json.encode(data.toJson());

class YearOfStudyAchievementModel {
  List<Content>? content;
  Pageable? pageable;
  int? totalPages;
  int? totalElements;
  bool? last;
  bool? first;
  int? numberOfElements;
  int? size;
  int? number;
  Sort? sort;
  bool? empty;

  YearOfStudyAchievementModel({
    this.content,
    this.pageable,
    this.totalPages,
    this.totalElements,
    this.last,
    this.first,
    this.numberOfElements,
    this.size,
    this.number,
    this.sort,
    this.empty,
  });

  factory YearOfStudyAchievementModel.fromJson(Map<String, dynamic> json) => YearOfStudyAchievementModel(
    content: json["content"] == null ? [] : List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    pageable: json["pageable"] == null ? null : Pageable.fromJson(json["pageable"]),
    totalPages: json["totalPages"],
    totalElements: json["totalElements"],
    last: json["last"],
    first: json["first"],
    numberOfElements: json["numberOfElements"],
    size: json["size"],
    number: json["number"],
    sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
    empty: json["empty"],
  );


  Map<String, dynamic> toJson() => {
    "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
    "pageable": pageable?.toJson(),
    "totalPages": totalPages,
    "totalElements": totalElements,
    "last": last,
    "first": first,
    "numberOfElements": numberOfElements,
    "size": size,
    "number": number,
    "sort": sort?.toJson(),
    "empty": empty,
  };
}

class Content {
  int? year;
  int? semester;
  List<Course>? course;

  Content({
    this.year,
    this.semester,
    this.course,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    year: json["year"],
    semester: json["semester"],
    course: json["course"] == null ? [] : List<Course>.from(json["course"]!.map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "semester": semester,
    "course": course == null ? [] : List<dynamic>.from(course!.map((x) => x.toJson())),
  };
}

class Course {
  String? title;
  int? score;
  int? credit;
  String? grade;

  Course({
    this.title,
    this.score,
    this.credit,
    this.grade,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
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
  int? pageNumber;
  int? pageSize;
  Sort? sort;
  int? offset;
  bool? unpaged;
  bool? paged;

  Pageable({
    this.pageNumber,
    this.pageSize,
    this.sort,
    this.offset,
    this.unpaged,
    this.paged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
    offset: json["offset"],
    unpaged: json["unpaged"],
    paged: json["paged"],
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "sort": sort?.toJson(),
    "offset": offset,
    "unpaged": unpaged,
    "paged": paged,
  };
}

class Sort {
  bool? unsorted;
  bool? sorted;
  bool? empty;

  Sort({
    this.unsorted,
    this.sorted,
    this.empty,
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
