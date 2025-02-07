class StudentCourseDetailModel {
  final int year;
  final int semester;
  final String courseTitle;
  final String courseDescription;
  final String courseLogo;
  final int credit;
  final int theory;
  final int practice;
  final int internship;
  final String? instructor;
  final String? position;
  final List<String> studentProfileImage;
  final String classesStart;
  final List<Module> curriculumModules;

  StudentCourseDetailModel({
    required this.year,
    required this.semester,
    required this.courseTitle,
    required this.courseDescription,
    required this.courseLogo,
    required this.credit,
    required this.theory,
    required this.practice,
    required this.internship,
    this.instructor,
    this.position,
    required this.studentProfileImage,
    required this.classesStart,
    required this.curriculumModules,
  });

  factory StudentCourseDetailModel.fromJson(Map<String, dynamic> json) {
    return StudentCourseDetailModel(
      year: json['year'],
      semester: json['semester'],
      courseTitle: json['courseTitle'],
      courseDescription: json['courseDescription'],
      courseLogo: json['courseLogo'],
      credit: json['credit'],
      theory: json['theory'],
      practice: json['practice'],
      internship: json['internship'],
      instructor: json['instructor'],
      position: json['position'],
      studentProfileImage: List<String>.from(json['studentProfileImage']),
      classesStart: json['classesStart'],
      // curriculumModules: (json['curriculum']['modules'] as List)
      //     .map((module) => Module.fromJson(module))
      //     .toList(),

      curriculumModules: (json['curriculum']?['modules'] as List<dynamic>?)
              ?.map((module) => Module.fromJson(module))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'semester': semester,
      'courseTitle': courseTitle,
      'courseDescription': courseDescription,
      'courseLogo': courseLogo,
      'credit': credit,
      'theory': theory,
      'practice': practice,
      'internship': internship,
      'instructor': instructor,
      'position': position,
      'studentProfileImage': studentProfileImage,
      'classesStart': classesStart,
      'curriculum': {
        'modules': curriculumModules.map((module) => module.toJson()).toList(),
      },
    };
  }
}

class Module {
  final String title;
  final String content;

  Module({
    required this.title,
    required this.content,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}
