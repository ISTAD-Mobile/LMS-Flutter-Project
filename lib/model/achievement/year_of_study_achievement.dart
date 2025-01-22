class YearOfStudyAchievement {
  final int year;
  final int semester;
  final List<Course> course;

  YearOfStudyAchievement({
    required this.year,
    required this.semester,
    required this.course,
  });

  factory YearOfStudyAchievement.fromJson(Map<String, dynamic> json) {
    var list = json['course'] as List;
    List<Course> courses = list.map((i) => Course.fromJson(i)).toList();

    return YearOfStudyAchievement(
      year: json['year'],
      semester: json['semester'],
      course: courses,
    );
  }
}

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
      score: json['score'],
      credit: json['credit'],
      grade: json['grade'],
    );
  }
}

class Response {
  final List<YearOfStudyAchievement> content;
  final int totalPages;

  Response({required this.content, required this.totalPages});

  factory Response.fromJson(Map<String, dynamic> json) {
    var list = json['content'] as List;
    List<YearOfStudyAchievement> achievements = list
        .map((i) => YearOfStudyAchievement.fromJson(i))
        .toList();

    return Response(
      content: achievements,
      totalPages: json['totalPages'],
    );
  }
}
