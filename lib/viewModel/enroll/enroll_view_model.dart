import 'package:flutter/material.dart';
import '../../model/enrollmentRequest/enroll.dart';
import '../../repository/enroll/enroll_step3_repo.dart';
import '../../data/response/status.dart';

class EnrollViewModel extends ChangeNotifier {
  final EnrollRepository _repository;

  EnrollViewModel(this._repository);

  Status _status = Status.IDLE;
  Status get status => _status;

  String? _error;
  String? get error => _error;

  EnrollModel? _enrollModel;
  EnrollModel? get enrollModel => _enrollModel;

  Future<void> enrollStudent({
    required int classId,
    required int studentId,
  }) async {
    try {
      _status = Status.LOADING;
      notifyListeners();

      final enrollData = EnrollModel(
        classId: classId,
        studentId: studentId,
      );

      _enrollModel = await _repository.postEnroll(enrollData);
      _status = Status.COMPLETED;
    } catch (e) {
      _status = Status.ERROR;
      _error = e.toString();
      _enrollModel = null;
    } finally {
      notifyListeners();
    }
  }
}

// class EnrollStep3ViewModel with ChangeNotifier {
//   final EnrollStep3Repo _repository;
//
//   EnrollStep3ViewModel(this._repository);
//
//   Status _status = Status.IDLE;
//   Status get status => _status;
//
//   String? _error;
//   String? get error => _error;
//
//   Future<void> enrollStudent({
//     required int classId,
//     required int studentId,
//   }) async {
//     _status = Status.LOADING;
//     notifyListeners();
//
//     try {
//       await _repository.postEnroll({
//         'classId': classId,
//         'studentId': studentId,
//       });
//       _status = Status.COMPLETED;
//     } catch (e) {
//       _status = Status.ERROR;
//       _error = e.toString();
//     }
//
//     notifyListeners();
//   }
// }
