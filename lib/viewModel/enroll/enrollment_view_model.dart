import 'package:flutter/material.dart';
import '../../data/response/status.dart';
import '../../model/enrollmentRequest/register_model.dart';
import '../../repository/enroll/enroll_repository.dart';

class EnrollmentViewModel extends ChangeNotifier {
  final EnrollmentRepository _repository;

  EnrollmentViewModel(this._repository);

  Status _status = Status.IDLE;
  Status get status => _status;

  String? _error;
  String? get error => _error;

  EnrollmentModel? _enrollmentModel;
  EnrollmentModel? get enrollmentModel => _enrollmentModel;

  Future<void> enrollUser(String url, EnrollmentModel enrollmentData) async {
    try {
      _status = Status.LOADING;
      notifyListeners();

      _enrollmentModel = await _repository.postEnrollment(enrollmentData);
      _status = Status.COMPLETED;
    } catch (e) {
      _status = Status.ERROR;
      _error = e.toString();
      _enrollmentModel = null;
    } finally {
      notifyListeners();
    }
  }
}

// class EnrollmentViewModel with ChangeNotifier {
//   final EnrollmentRepository _repository;
//
//   EnrollmentViewModel(this._repository);
//
//   Status _status = Status.IDLE;
//   Status get status => _status;
//
//   EnrollmentModel? _enrollmentModel;
//   EnrollmentModel? get enrollmentModel => _enrollmentModel;
//
//   String? _error;
//   String? get error => _error;
//
//   Future<void> enrollUser(String url, EnrollmentModel enrollment) async {
//     _status = Status.LOADING;
//     notifyListeners();
//
//     try {
//       _enrollmentModel = await _repository.enrollUser(url, enrollment);
//       _status = Status.COMPLETED;
//     } catch (e) {
//       _status = Status.ERROR;
//       _error = e.toString();
//     }
//
//     notifyListeners();
//   }
// }