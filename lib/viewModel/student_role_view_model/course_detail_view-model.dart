import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;

class StudentCourseDetailsViewmodel extends ChangeNotifier {
  final String token;
  bool isLoading = false;
  StudentCourseDetail? studentCourseDetail;
  String? error;

  StudentCourseDetailsViewmodel({required this.token}) {
    print('Token received in ViewModel constructor: ${token.substring(0, math.min(10, token.length))}...');
  }

  Future<void> getStudentCourseDetail(String uuid) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      print('Making API call with token: ${token.substring(0, math.min(10, token.length))}...');
      print('UUID: $uuid');

      final response = await http.get(
        Uri.parse('https://dev-flutter.cstad.edu.kh/api/v1/students/course/$uuid'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        studentCourseDetail = StudentCourseDetail.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please check your token or log in again.');
      } else {
        throw Exception('Failed to load course details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      error = e.toString();
      print('Error in getStudentCourseDetail: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
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
      title: json['title'] ?? '',
      content: json['content'] ?? '',
    );
  }
}

class Curriculum {
  final List<Module> modules;

  Curriculum({
    required this.modules,
  });

  factory Curriculum.fromJson(Map<String, dynamic> json) {
    return Curriculum(
      modules: (json['modules'] as List<dynamic>)
          .map((moduleJson) => Module.fromJson(moduleJson))
          .toList(),
    );
  }
}

class StudentCourseDetail {
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
  final List<String?> studentProfileImage;
  final String classesStart;
  final Curriculum curriculum;

  StudentCourseDetail({
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
    required this.curriculum,
  });

  factory StudentCourseDetail.fromJson(Map<String, dynamic> json) {
    return StudentCourseDetail(
      year: json['year'] ?? 0,
      semester: json['semester'] ?? 0,
      courseTitle: json['courseTitle'] ?? '',
      courseDescription: json['courseDescription'] ?? '',
      courseLogo: json['courseLogo'] ?? '',
      credit: json['credit'] ?? 0,
      theory: json['theory'] ?? 0,
      practice: json['practice'] ?? 0,
      internship: json['internship'] ?? 0,
      instructor: json['instructor'],
      position: json['position'],
      studentProfileImage: (json['studentProfileImage'] as List<dynamic>)
          .map((img) => img as String?)
          .toList(),
      classesStart: json['classesStart'] ?? '',
      curriculum: Curriculum.fromJson(json['curriculum'] ?? {'modules': []}),
    );
  }
}