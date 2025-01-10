// class YearOfStudyAchievement {
//   final int year;
//   final int semester;
//   final List<Course> courses;
//   final int credit;
//
//   YearOfStudyAchievement({
//     required this.year,
//     required this.semester,
//     required this.courses,
//     required this.credit,
//   });
//
//   // Factory method to parse from JSON
//   factory YearOfStudyAchievement.fromJson(Map<String, dynamic> json) {
//     return YearOfStudyAchievement(
//       year: json['year'] as int,
//       semester: json['semester'] as int,
//       credit: (json['credit'] as int),
//       courses: (json['course'] as List)
//           .map((course) => Course.fromJson(course as Map<String, dynamic>))
//           .toList(),
//     );
//   }
//
//   // Method to convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'year': year,
//       'semester': semester,
//       'credit': credit,
//       'course': courses.map((course) => course.toJson()).toList(),
//     };
//   }
// }
//
// class Course {
//   final String title;
//   final double score;
//   final int credit;
//   final String grade;
//
//   Course({
//     required this.title,
//     required this.score,
//     required this.credit,
//     required this.grade,
//   });
//
//   // Factory method to parse from JSON
//   factory Course.fromJson(Map<String, dynamic> json) {
//     return Course(
//       title: json['title'] as String,
//       score: json['score'] as double,
//       credit: json['credit'] as int,
//       grade: json['grade'] as String,
//     );
//   }
//
//   // Method to convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'score': score,
//       'credit': credit,
//       'grade': grade,
//     };
//   }
// }
//
// class AchievementResponse {
//   final List<YearOfStudyAchievement> achievements;
//
//   AchievementResponse({required this.achievements});
//
//   // Factory method to parse from JSON
//   factory AchievementResponse.fromJson(Map<String, dynamic> json) {
//     return AchievementResponse(
//       achievements: (json['content'] as List)
//           .map((achievement) => YearOfStudyAchievement.fromJson(
//               achievement as Map<String, dynamic>))
//           .toList(),
//     );
//   }
//
//   // Method to convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'content':
//           achievements.map((achievement) => achievement.toJson()).toList(),
//     };
//   }
// }



// To parse this JSON data, do
//
//     final yearOfStudyAchievement = yearOfStudyAchievementFromJson(jsonString);

import 'dart:convert';

YearOfStudyAchievement yearOfStudyAchievementFromJson(String str) => YearOfStudyAchievement.fromJson(json.decode(str));

String yearOfStudyAchievementToJson(YearOfStudyAchievement data) => json.encode(data.toJson());

class YearOfStudyAchievement {
  List<Content>? content;

  YearOfStudyAchievement({
    this.content,
  });

  factory YearOfStudyAchievement.fromJson(Map<String, dynamic> json) => YearOfStudyAchievement(
    content: json["content"] == null ? [] : List<Content>.from(json["content"]!.map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
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
