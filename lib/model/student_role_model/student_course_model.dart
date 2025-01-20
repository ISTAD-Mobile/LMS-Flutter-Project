class StudentCoursesModel {
  final String uuid;
  final String nameEn;
  final String nameKh;
  final String username;
  final String gender;
  final String avatar;
  final String profileImage;
  final List<Course> courses;

  StudentCoursesModel({
    required this.uuid,
    required this.nameEn,
    required this.nameKh,
    required this.username,
    required this.gender,
    required this.avatar,
    required this.profileImage,
    required this.courses,
  });

  factory StudentCoursesModel.fromJson(Map<String, dynamic> json) {
    return StudentCoursesModel(
      uuid: json['uuid'] ?? '',
      nameEn: json['nameEn'] ?? '',
      nameKh: json['nameKh'] ?? '',
      username: json['username'] ?? '',
      gender: json['gender'] ?? '',
      avatar: json['avatar'] ?? '',
      profileImage: json['profileImage'] ?? '',
      courses: (json['courses'] as List<dynamic>?)
          ?.map((course) => Course.fromJson(course as Map<String, dynamic>))
          .toList() ??
          [], // Return an empty list if 'courses' is null
    );
  }
}

class Course {
  final String uuid;
  final String title;
  final int credit;
  final String logo;
  final String description;
  final double progress;
  final int year;
  final int semester;

  Course({
    required this.uuid,
    required this.title,
    required this.credit,
    required this.logo,
    required this.description,
    required this.progress,
    required this.year,
    required this.semester,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      uuid: json['uuid'] ?? '',
      title: json['title'] ?? '',
      credit: json['credit'] ?? 0,
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      year: json['year'] ?? 0,
      semester: json['semester'] ?? 0,
    );
  }
}