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



import 'dart:convert';

class YearOfStudyAchievement {
  List<Content>? content;

  YearOfStudyAchievement({this.content});

  factory YearOfStudyAchievement.fromJson(Map<String, dynamic> json) {
    return YearOfStudyAchievement(
      content: json["content"] == null
          ? []
          : List<Content>.from(
          json["content"].map((x) => Content.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "content": content == null
          ? []
          : List<dynamic>.from(content!.map((x) => x.toJson())),
    };
  }
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

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      year: json["year"],
      semester: json["semester"],
      course: json["course"] == null
          ? []
          : List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "year": year,
      "semester": semester,
      "course": course == null
          ? []
          : List<dynamic>.from(course!.map((x) => x.toJson())),
    };
  }
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

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json["title"],
      score: json["score"],
      credit: json["credit"],
      grade: json["grade"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "score": score,
      "credit": credit,
      "grade": grade,
    };
  }
}
