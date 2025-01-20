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

// class YearOfStudyAchievement {
//   List<Content>? content;
//
//   YearOfStudyAchievement({this.content});
//
//   factory YearOfStudyAchievement.fromJson(Map<String, dynamic> json) {
//     return YearOfStudyAchievement(
//       content: json["content"]?.map((x) => Content.fromJson(x)).toList() ?? [],
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
// class YearOfStudyAchievement {
//   final List<Content> content;
//
//   YearOfStudyAchievement({
//     required this.content,
//   });
//
//   factory YearOfStudyAchievement.fromJson(Map<String, dynamic> json) {
//     return YearOfStudyAchievement(
//       content: json['content'] != null
//           ? List<Content>.from(json['content'].map((x) => Content.fromJson(x)))
//           : [],  // If content is null, return an empty list
//     );
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
//       year: json["year"] != null ? int.tryParse(json["year"].toString()) : null,
//       semester: json["semester"],
//       course: json["course"]?.map((x) => Course.fromJson(x)).toList() ?? [],
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

class Course {
  final String title;
  final double score;
  final int credit;
  final String grade;

  Course({
    required this.title,
    required this.score,
    required this.credit,
    required this.grade,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      score: (json['score'] as num).toDouble(),
      credit: json['credit'],
      grade: json['grade'],
    );
  }
}

class Semester {
  final int year;
  final int semester;
  final List<Course> courses;

  Semester({
    required this.year,
    required this.semester,
    required this.courses,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      year: json['year'],
      semester: json['semester'],
      courses: (json['course'] as List<dynamic>)
          .map((course) => Course.fromJson(course))
          .toList(),
    );
  }
}

class YearOfStudyAchievementResponse {
  final List<Semester> content;

  YearOfStudyAchievementResponse({required this.content});

  factory YearOfStudyAchievementResponse.fromJson(Map<String, dynamic> json) {
    return YearOfStudyAchievementResponse(
      content: (json['content'] as List<dynamic>)
          .map((semester) => Semester.fromJson(semester))
          .toList(),
    );
  }
}
