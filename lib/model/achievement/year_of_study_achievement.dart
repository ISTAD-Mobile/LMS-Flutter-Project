import 'dart:convert';

YearOfStudyAchievement yearOfStudyAchievementFromJson(String str) => YearOfStudyAchievement.fromJson(json.decode(str));

String yearOfStudyAchievementToJson(YearOfStudyAchievement data) => json.encode(data.toJson());

class YearOfStudyAchievement {
  List<Content> content;

  YearOfStudyAchievement({
    required this.content,
  });

  factory YearOfStudyAchievement.fromJson(Map<String, dynamic> json) => YearOfStudyAchievement(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
  };
}

class Content {
  int year;
  int semester;
  List<Course> course;

  Content({
    required this.year,
    required this.semester,
    required this.course,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    year: json["year"],
    semester: json["semester"],
    course: List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "semester": semester,
    "course": List<dynamic>.from(course.map((x) => x.toJson())),
  };
}

class Course {
  String title;
  int score;
  int credit;
  String grade;

  Course({
    required this.title,
    required this.score,
    required this.credit,
    required this.grade,
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
