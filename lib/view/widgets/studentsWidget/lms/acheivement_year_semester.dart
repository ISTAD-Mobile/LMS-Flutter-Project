// import 'package:flutter/material.dart';
// import '../../../../model/achievement/year_of_study_achievement.dart';
// import '../../../../repository/achievement/year_of_study_achievement_repository.dart';
// import '../../../../viewModel/achievement/year_of_study_achievement_viewmodel.dart';
//
// class YearOfStudyAchievementScreen extends StatefulWidget {
//   final String accessToken;
//
//   YearOfStudyAchievementScreen({required this.accessToken});
//
//   @override
//   _AchievementScreenState createState() => _AchievementScreenState();
// }
//
// class _AchievementScreenState extends State<YearOfStudyAchievementScreen> {
//   late YearOfStudyAchievementViewModel viewModel;
//
//   @override
//   void initState() {
//     super.initState();
//
//     final repository = YearOfStudyAchievementRepository(
//       accessToken: widget.accessToken,
//     );
//
//     viewModel = YearOfStudyAchievementViewModel(repository: repository);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<YearOfStudyAchievement>>(
//         future: viewModel.fetchAchievements(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No data available.'));
//           }
//
//           final achievements = snapshot.data!;
//
//           return ListView.builder(
//             itemCount: achievements.length,
//             itemBuilder: (context, index) {
//               final achievement = achievements[index];
//
//               return Container(
//                 margin: EdgeInsets.all(10),
//                 child: PhysicalModel(
//                   color: Colors.white,
//                   elevation: 5,
//                   borderRadius: BorderRadius.circular(10),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Title for Year and Semester
//                         Text(
//                           'Year ${achievement.year}  Semester ${achievement.semester}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         _buildGradesTable(achievement.course),
//                         const SizedBox(height: 12),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildGradesTable(List<Course> courses) {
//     final headers = ['NO', 'Title', 'Score', 'Credit', 'Grade'];
//     int totalCourse = courses.length;
//     int totalCredit = courses.fold(0, (sum, course) => sum + course.credit);
//     double totalGradePoints = courses.fold(0.0, (sum, course) {
//       double gradePoints = _getGradePoints(course.grade);
//       return sum + (gradePoints * course.credit);
//     });
//     double gpa = totalCredit > 0 ? totalGradePoints / totalCredit : 0.0;
//
//     return Column(
//       children: [
//         Table(
//           border: TableBorder.all(
//             color: Colors.grey.shade300,
//             width: 1,
//           ),
//           columnWidths: const {
//             0: FlexColumnWidth(0.5),
//             1: FlexColumnWidth(2.5),
//             2: FlexColumnWidth(1),
//             3: FlexColumnWidth(0.8),
//             4: FlexColumnWidth(0.8),
//           },
//           children: [
//             TableRow(
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//               ),
//               children: headers.map((header) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     header,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             ...courses.asMap().entries.map((entry) {
//               final index = entry.key;
//               final course = entry.value;
//
//               return TableRow(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text((index + 1).toString(), style: const TextStyle(fontSize: 12)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(course.title, style: const TextStyle(fontSize: 12)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(course.score.toString(), style: const TextStyle(fontSize: 12)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(course.credit.toString(), style: const TextStyle(fontSize: 12)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(course.grade, style: const TextStyle(fontSize: 12)),
//                   ),
//                 ],
//               );
//             }).toList(),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             'Total Course: $totalCourse    Total Credit: $totalCredit    GPA: ${gpa.toStringAsFixed(2)}',
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//           ),
//         ),
//       ],
//     );
//   }
//
// // Function to map grade to grade points (GPA scale)
//   double _getGradePoints(String grade) {
//     switch (grade) {
//       case 'A':
//         return 4.0;
//       case 'B':
//         return 3.0;
//       case 'C':
//         return 2.0;
//       case 'D':
//         return 1.0;
//       case 'F':
//         return 0.0;
//       default:
//         return 0.0;
//     }
//   }
//
//
// }


import 'package:flutter/material.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../model/achievement/year_of_study_achievement.dart';
import '../../../../repository/achievement/year_of_study_achievement_repository.dart';
import '../../../../viewModel/achievement/year_of_study_achievement_viewmodel.dart';

class YearOfStudyAchievementScreen extends StatefulWidget {
  final String token;

  YearOfStudyAchievementScreen({required this.token});

  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<YearOfStudyAchievementScreen> {
  late YearOfStudyAchievementViewModel viewModel;

  @override
  void initState() {
    super.initState();

    final repository = YearOfStudyAchievementRepository(
      accessToken: widget.token,
    );

    viewModel = YearOfStudyAchievementViewModel(repository: repository);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<YearOfStudyAchievement>>(
      future: viewModel.fetchAchievements(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available.'));
        }

        final achievements = snapshot.data!;

        return SingleChildScrollView(
          child: Column(
            children: achievements.map((achievement) {
              return PhysicalModel(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title for Year and Semester
                      Text(
                        'Year ${achievement.year}  Semester ${achievement.semester}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildGradesTable(achievement.course),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildGradesTable(List<Course> courses) {
    final headers = ['NO', 'Title', 'Score', 'Credit', 'Grade'];
    int totalCourse = courses.length;
    int totalCredit = courses.fold(0, (sum, course) => sum + course.credit);
    double totalGradePoints = courses.fold(0.0, (sum, course) {
      double gradePoints = _getGradePoints(course.grade);
      return sum + (gradePoints * course.credit);
    });
    double gpa = totalCredit > 0 ? totalGradePoints / totalCredit : 0.0;

    return Column(
      children: [
        Table(
          border: TableBorder.all(
            color: Colors.grey.shade300,
            width: 1,
            borderRadius: BorderRadius.circular(8.0),
          ),
          columnWidths: const {
            0: FlexColumnWidth(0.7),
            1: FlexColumnWidth(2.5),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              children: headers.map((header) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    header,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
            ...courses.asMap().entries.map((entry) {
              final index = entry.key;
              final course = entry.value;

              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text((index + 1).toString(), style: const TextStyle(fontSize: 12)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(course.title, style: const TextStyle(fontSize: 12)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(course.score.toString(), style: const TextStyle(fontSize: 12)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(course.credit.toString(), style: const TextStyle(fontSize: 12)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(course.grade, style: const TextStyle(fontSize: 12)),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total Course: $totalCourse    Total Credit: $totalCredit    GPA: ${gpa.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,),
          ),
        ),
      ],
    );
  }

  // Function to map grade to grade points (GPA scale)
  double _getGradePoints(String grade) {
    switch (grade) {
      case 'A':
        return 4.0;
      case 'B':
        return 3.0;
      case 'C':
        return 2.0;
      case 'D':
        return 1.0;
      case 'F':
        return 0.0;
      default:
        return 0.0;
    }
  }
}