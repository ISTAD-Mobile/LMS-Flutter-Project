import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/achievement/year_of_study_achievement_repository.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';
import 'package:lms_mobile/viewModel/achievement/year_of_study_achievement_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../data/response/status.dart';
import '../../../../model/achievement/year_of_study_achievement.dart';
import '../../../../viewModel/student_profile_viewModel.dart';

class AcheivementScreen extends StatelessWidget {
  final String accessToken;

  AcheivementScreen({required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              StudenProfileDataViewModel(
                  userRepository: StudentProfileRepository(
                      accessToken: accessToken)
              ),
        ),
        ChangeNotifierProvider(
          create: (_) => YearOfStudyAchievementViewmodel(),

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
                _buildSemesterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Building the Welcome Banner
  Widget _buildWelcomeBanner() {
    return Consumer<StudenProfileDataViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.user == null && !viewModel.isLoading &&
            viewModel.errorMessage == null) {
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
                    backgroundImage: user.profileImage != null &&
                        user.profileImage!.isNotEmpty
                        ? NetworkImage(user.profileImage!)
                        : const AssetImage('assets/images/placeholder.jpg')
                    as ImageProvider,
                  ),
                ),
                Positioned(
                  top: 95,
                  left: 130.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.nameEn}',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        '12 Course',
                        style: TextStyle(
                            color: AppColors.defaultGrayColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Building the Transcript Section
  Widget _buildTranscript() {
    return Consumer<StudenProfileDataViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.user == null) {
          return const Center(child: Text("Loading transcript..."));
        }
        final user = viewModel.user!;
        return Container(
          margin: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
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
                    textAlign: TextAlign.center,
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
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 170,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: user.profileImage != null &&
                          user.profileImage!.isNotEmpty
                          ? NetworkImage(user.profileImage!)
                          : const AssetImage('assets/images/placeholder.jpg')
                      as ImageProvider,
                      fit: BoxFit.cover,
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
      builder: (context, viewModel, child) {
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

  Widget _buildSemesterSection() {
    return Consumer<YearOfStudyAchievementViewmodel>(
      builder: (context, viewModel, child) {
        // Check for loading state, assuming ApiResponse has a status property
        if (viewModel.yearOfStudyList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message if any
        if (viewModel.yearOfStudy.message != null) {
          return Center(
            child: Text(
              viewModel.yearOfStudy.message!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Show message if no achievements are available
        if (viewModel.yearOfStudy.data == null || viewModel.yearOfStudy.data!.yearOfStudy.isEmpty) {
          return const Center(
            child: Text("No achievements available."),
          );
        }

        var yearOfStudyData = viewModel.yearOfStudyList;

        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: yearOfStudyData.map((semester) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display Year and Semester info
                  Text(
                    "Year ${semester.year} - Semester ${semester.semester}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Check if there are courses available for this semester
                  if (semester.courseList.isNotEmpty)
                    Column(
                      children: semester.courseList.map((course) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(course.title ?? 'No Title'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Score: ${course.score ?? 'Not Available'}'),
                                  Text('Credit: ${course.credit ?? 'Not Available'}'),
                                  Text('Grade: ${course.grade ?? 'Not Available'}'),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  else
                    const Text("No courses available."),

                  const SizedBox(height: 16), // Spacer between semesters
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }








// // Building the Grades Table
//   Widget _buildGradesTable(Course content) {
//     const headers = ['NO', 'Title', 'Score', 'Credit', 'Grade'];
//     final courses = content[0].courses.asMap().entries.map((entry) {
//       final index = entry.key + 1;
//       final course = entry.value;
//       return [
//         index,
//         course.title,
//         course.score.toString(),
//         course.credit.toString(),
//         course.grade,
//       ];
//     }).toList();
//
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Table(
//         border: TableBorder.all(),
//         columnWidths: const {
//           0: FlexColumnWidth(0.5),
//           1: FlexColumnWidth(2.5),
//           2: FlexColumnWidth(1),
//           3: FlexColumnWidth(0.8),
//           4: FlexColumnWidth(0.8),
//         },
//         children: [
//           // Header Row
//           TableRow(
//             decoration: BoxDecoration(color: Colors.grey.shade100),
//             children: headers.map((header) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   header,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               );
//             }).toList(),
//           ),
//           // Data Rows
//           if (courses.isEmpty)
//             TableRow(
//               children: List.generate(
//                 headers.length,
//                     (index) => TableCell(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       index == 0 ? 'No courses available' : '',
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           else
//             ...courses.map((course) {
//               return TableRow(
//                 children: course.map((cell) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(cell.toString()),
//                   );
//                 }).toList(),
//               );
//             }).toList(),
//         ],
//       ),
//     );
//   }





}
