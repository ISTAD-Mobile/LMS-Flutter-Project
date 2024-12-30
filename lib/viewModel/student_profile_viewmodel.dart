// import 'package:flutter/material.dart';
// import 'package:lms_mobile/data/response/api_response.dart';
// import 'package:lms_mobile/model/student_profile.dart';
// import 'package:lms_mobile/repository/student_profile_repository.dart';
//
// class StudentProfileViewModel extends ChangeNotifier {
//   final _studentProfileRepo = StudentProfileRepository(accessToken: '');
//
//   ApiResponse<StudentProfile> response = ApiResponse.loading();
//
//   // Update the response and notify listeners
//   void setStudentProfileList(ApiResponse<StudentProfile> response) {
//     this.response = response;
//     notifyListeners();
//   }
//
//   // Fetch all student profiles
//   Future<void> getAllStudentProfile() async {
//     setStudentProfileList(ApiResponse.loading()); // Set loading state
//     try {
//       // final studentProfile = await _studentProfileRepo.getStudentProfile();
//       setStudentProfileList(ApiResponse.completed(studentProfile));
//     } catch (error) {
//       setStudentProfileList(ApiResponse.error(error.toString()));
//     }
//   }
// }
