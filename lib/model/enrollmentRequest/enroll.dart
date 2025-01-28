class EnrollmentModelStep2 {
  final int classId;
  final int studentId;

  EnrollmentModelStep2({
    required this.classId,
    required this.studentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'classId': classId,
      'studentId': studentId,
    };
  }
}
