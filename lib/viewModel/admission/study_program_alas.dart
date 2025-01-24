import 'package:flutter/material.dart';
import 'package:lms_mobile/model/admission/study_program_alas.dart';
import '../../data/response/api_response.dart';
import '../../repository/admission/study_program_alas.dart';

class StudyProgramAlasViewModel extends ChangeNotifier {
  final StudyProgramAlasRepository studyProgramAlasRepository = StudyProgramAlasRepository();
  ApiResponse<List<StudyProgramAlasModel>> studyProgramList = ApiResponse.loading();

  void setStudyProgramList(ApiResponse<List<StudyProgramAlasModel>> response) {
    studyProgramList = response;
    notifyListeners();
  }

  Future<void> fetchAllStudyPrograms() async {
    try {
      setStudyProgramList(ApiResponse.loading());
      final data = await studyProgramAlasRepository.getAllStudyProgarmAlas();
      setStudyProgramList(ApiResponse.completed(data));
    } catch (error, stackTrace) {
      setStudyProgramList(ApiResponse.error(error.toString()));
      debugPrint('Error fetching study programs: $error');
    }
  }

  List<String> get studyProgramNames {
    try {
      if (studyProgramList.data == null) return [];
      return studyProgramList.data!.map((program) => program.alias ?? '').toList();
    } catch (e) {
      debugPrint('Error converting study program names: $e');
      return [];
    }
  }

  List<StudyProgramAlasModel> get fullStudyProgramData {
    return studyProgramList.data ?? [];
  }
}
