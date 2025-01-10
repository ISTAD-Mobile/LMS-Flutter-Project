import 'package:flutter/material.dart';
import 'package:lms_mobile/model/achievement/year_of_study_achievement.dart';
import 'package:lms_mobile/repository/achievement/year_of_study_achievement_repository.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';
import 'package:lms_mobile/viewModel/achievement/year_of_study_achievement_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../viewModel/student_profile_viewModel.dart';

class AcheivementScreen extends StatelessWidget {
  final String accessToken;
  const AcheivementScreen({required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => StudenProfileDataViewModel(
            userRepository: StudentProfileRepository(accessToken: accessToken)
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => YearOfStudyAchievementViewmodel(
          userRepository: YearOfStudyAchievementRepository(accessToken: accessToken),
        ), // Fetch data immediately
      ),
    ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildWelcomeBanner(),
                _buildTranscript(),
                _buildStudentInfo(),
                _buildSemesterSection(0),
                // _buildSemesterSection(1),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildWelcomeBanner() {
    return Consumer<StudenProfileDataViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.user == null && !viewModel.isLoading && viewModel.errorMessage == null) {
          viewModel.fetchUserData();
        }

        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.errorMessage != null) {
          return Center(child: Text("Error: ${viewModel.errorMessage}"));
        } else if (viewModel.user == null) {
          return const Center(child: Text("No user data found"));
        } else {
          final user = viewModel.user!;
          return Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.fromLTRB(0, 16, 15, 20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 130.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, ${user.nameEn}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Passionate about literature and creative writing.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 0.0,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: user.profileImage != null && user.profileImage!.isNotEmpty
                          ? NetworkImage(user.profileImage!)
                          : const AssetImage('assets/images/placeholder.jpg') as ImageProvider,
                    ),
                  ),
                  Positioned(
                    top: 95,
                    left: 130.0,// Adjust the vertical position
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${user.nameEn}',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '12 Course',
                          style: TextStyle(
                              color: AppColors.defaultGrayColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          );
        }
      },
    );
  }

  Widget _buildTranscript() {
    return Consumer<StudenProfileDataViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.user == null) {
          return const Center(child: Text("Loading transcript..."));
        }
        final user = viewModel.user!;
        return Container(
          margin: const EdgeInsets.fromLTRB(0.0,70.0,0.0,20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Center of Science and Technology Advanced Development',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.center, // Ensures multiline text is centered
                  ),
                  SizedBox(height: 4),
                  Text(
                    'OFFICIAL TRANSCRIPT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadius.circular(12), // Adjust the radius for rounded corners
                child: Container(
                  height: 170, // Set the desired height
                  width: 140,  // Set the width to maintain proportions
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: user.profileImage != null && user.profileImage!.isNotEmpty
                          ? NetworkImage(user.profileImage!)
                          : const AssetImage('assets/images/placeholder.jpg') as ImageProvider,
                      fit: BoxFit.cover, // Ensures the image fills the shape properly
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStudentInfo() {
    return Consumer<StudenProfileDataViewModel>(
      builder: (context, viewModel, Widget? child) {
        if (viewModel.user == null) {
          return const Center(child: Text("Loading user data..."));
        }
        final user = viewModel.user!;
        final infoData = {
          'Name (KH)': user.nameKh,
          'Name (EN)': user.nameEn,
          'Date of Birth': user.dob,
          'Degree': user.degree,
          'Major': user.major,
        };

        return Column(
          children: infoData.entries.map((entry) {
            bool isKhmerText = entry.key.contains('KH') || _isKhmerText(entry.value);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                    width: 120,
                    child: Text(
                      entry.key,
                      style: const TextStyle(
                        color: AppColors.defaultGrayColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Text(' :  '),
                  Flexible(
                    child: Text(
                      entry.value ?? 'N/A',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.defaultGrayColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: isKhmerText ? 'NotoSansKhmer' : null, // Apply Khmer font if needed
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  bool _isKhmerText(String? text) {
    // Check if the text contains Khmer characters (unicode range)
    return text != null && RegExp(r'[\u1780-\u17FF]').hasMatch(text);
  }


  // Widget _buildSemesterSection(int index) {
  //   return Consumer<YearOfStudyAchievementViewModel>(
  //     builder: (context, viewModel, child) {
  //       // Fetch data if not already fetched
  //       if (viewModel.yearOfStudyAchievement == null && !viewModel.isLoading && viewModel.errorMessage == null) {
  //         viewModel.fetchYearOfStudyData(accessToken); // Ensure `accessToken` is available
  //       }
  //
  //       if (viewModel.isLoading) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //
  //       if (viewModel.errorMessage != null) {
  //         return Center(
  //           child: Text(
  //             "Error: ${viewModel.errorMessage}",
  //             style: const TextStyle(color: Colors.red),
  //           ),
  //         );
  //       }
  //
  //       if (viewModel.yearOfStudyAchievement != null) {
  //         final yearSemester = viewModel.getYearSemester(index);
  //         final totalCourses = viewModel.getTotalCourses(index);
  //         final totalCredits = viewModel.getTotalCredits(index);
  //         final gpa = viewModel.getGPA(index);
  //
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               yearSemester,
  //               style: const TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //                 color: AppColors.primaryColor,
  //               ),
  //             ),
  //             const SizedBox(height: 24),
  //             _buildGradesTable(viewModel, index), // Fetch data dynamically
  //             const SizedBox(height: 12),
  //             Text(
  //               'Total Course: $totalCourses     GPA: ${gpa.toStringAsFixed(2)}     Credit: $totalCredits',
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w400,
  //                 color: AppColors.primaryColor,
  //               ),
  //             ),
  //           ],
  //         );
  //       }
  //
  //       return const Center(child: Text("No data available."));
  //     },
  //   );
  // }
  Widget _buildSemesterSection(int index) {
    return Consumer<YearOfStudyAchievementViewmodel>(
      builder: (context, viewModel, child) {
        if (viewModel.achievements == null && !viewModel.isLoading && viewModel.errorMessage == null) {
          viewModel.fetchAchievements();
        }

        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.errorMessage != null) {
          return Center(child: Text("Error: ${viewModel.errorMessage}"));
        } else if (viewModel.achievements == null || viewModel.achievements!.isEmpty) {
          return const Center(child: Text("No achievements data found."));
        } else {
          final achievement = viewModel.achievements![index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Year ${achievement.content![0].year} - Semester ${achievement.content![0].semester}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 24),
              _buildGradesTable(achievement),
              const SizedBox(height: 12),
              Text(
                'Total Course: ${achievement.content![0].course}     GPA: ${achievement}     Credit: ${achievement.content![0].course![0].credit}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          );
        }
      },
    );
  }



  // Widget _buildGradesTable(YearOfStudyAchievementViewModel viewModel, int index) {
  //   // Get the relevant content for the specified year/semester
  //   final content = viewModel.yearOfStudyAchievement?.content[index];
  //
  //   if (content == null) {
  //     return const Center(child: Text("No courses available."));
  //   }
  //
  //   final headers = ['NO', 'Title', 'Score', 'Credit', 'Grade'];
  //   final courses = content.course.map((course) {
  //     return [
  //       content.course.indexOf(course) + 1, // Course number (index + 1)
  //       course.title,
  //       course.score.toString(),
  //       course.credit.toString(),
  //       course.grade,
  //     ];
  //   }).toList();
  //
  //   return Table(
  //     border: TableBorder.all(
  //       color: Colors.grey.shade300,
  //       width: 1,
  //     ),
  //     columnWidths: const {
  //       0: FlexColumnWidth(0.5),
  //       1: FlexColumnWidth(2.5),
  //       2: FlexColumnWidth(1),
  //       3: FlexColumnWidth(0.8),
  //       4: FlexColumnWidth(0.8),
  //     },
  //     children: [
  //       TableRow(
  //         decoration: BoxDecoration(
  //           color: Colors.grey.shade100,
  //         ),
  //         children: headers.map((header) {
  //           return Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               header,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 12,
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //       ...courses.map((course) {
  //         return TableRow(
  //           children: course.map((cell) {
  //             return Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 cell.toString(),
  //                 style: const TextStyle(fontSize: 12),
  //               ),
  //             );
  //           }).toList(),
  //         );
  //       }).toList(),
  //     ],
  //   );
  // }
  Widget _buildGradesTable(YearOfStudyAchievement achievement) {
    // Define Table Headers
    final headers = ['NO', 'Title', 'Score', 'Credit', 'Grade'];

    // Convert Course Data to Table Rows
    final courses = achievement.content![0].course!.map((course) {
      return [
        achievement.content![0].course!.indexOf(course) + 1, // Course number (index + 1)
        course.title,
        course.score.toString(),
        course.credit.toString(),
        course.grade,
      ];
    }).toList();

    // Build the Table Widget
    return Table(
      border: TableBorder.all(
        color: Colors.grey.shade300,
        width: 1,
      ),
      columnWidths: const {
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(2.5),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(0.8),
        4: FlexColumnWidth(0.8),
      },
      children: [
        // Table Headers Row
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
        // Table Rows for Courses
        ...courses.map((course) {
          return TableRow(
            children: course.map((cell) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cell.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ],
    );
  }


}