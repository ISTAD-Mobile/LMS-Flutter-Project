// import 'package:flutter/material.dart';
//
// import '../../../../data/color/color_screen.dart';
//
// class AcheivementScreen extends StatelessWidget {
//   const AcheivementScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _buildWelcomeBanner(),
//               _buildTranscript(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildWelcomeBanner() {
//     return Container(
//       margin: const EdgeInsets.all(20.0),
//       padding: const EdgeInsets.fromLTRB(0, 16,15, 20),
//       decoration: BoxDecoration(
//         color: AppColors.primaryColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: const Stack(
//         clipBehavior: Clip.none, // Ensures content is not clipped outside Stack
//         children: [
//           // Main content of the card
//           Padding(
//             padding: EdgeInsets.only(left: 130.0), // Space for the image
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome back, Nhoem Tevy',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 4,),
//                 Text(
//                   'Passionate about literature and creative writing.',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Positioned image
//           Positioned(
//             top: 20 ,
//             left: 0.0,// Adjust the vertical position
//             child: CircleAvatar(
//               radius: 60,
//               backgroundImage: AssetImage('assets/images/tevy.png'),
//             ),
//           ),
//           Positioned(
//             top: 95,
//             left: 130.0,// Adjust the vertical position
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                   Text('Nhoem Tevy',
//                     style: TextStyle(
//                       color: AppColors.primaryColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 SizedBox(height: 2),
//                 Text(
//                   '12 Course',
//                   style: TextStyle(
//                     color: AppColors.defaultGrayColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTranscript() {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(0.0,70.0,0.0,20.0),
//       padding: const EdgeInsets.all(20.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         // borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Center of Science and Technology Advanced Development',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.primaryColor,
//                 ),
//                 textAlign: TextAlign.center, // Ensures multiline text is centered
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'OFFICIAL TRANSCRIPT',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.primaryColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12), // Adjust the radius for rounded corners
//             child: const Image(
//               image: AssetImage('assets/images/tevy1.png'),
//               height: 170, // Set the desired height
//               width: 140,  // Set the width to maintain proportions
//               fit: BoxFit.cover, // Ensures the image fills the shape properly
//             ),
//           ),
//
//           const SizedBox(height: 40),
//           _buildStudentInfo(),
//           const SizedBox(height: 16),
//           _buildSemesterSection('Year 1 Semester 1'),
//           const SizedBox(height: 16),
//           _buildSemesterSection('Year 1 Semester 2'),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStudentInfo() {
//     final infoData = {
//       'Name (KH)': 'ញឹម ទេវី',
//       'Name (EN)': 'Nhoem Tevy',
//       'Date of Birth': '2007-10-20',
//       'Degree': 'Association Degree',
//       'Major': 'Association of Information Technology',
//     };
//
//     return Column(
//       children: infoData.entries.map((entry) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 35,
//                 width: 120,
//                 child: Text(
//                   entry.key,
//                   style: const TextStyle(
//                     color: AppColors.defaultGrayColor,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               const Text(' :  '),
//               Expanded(
//                 child: Text(
//                   entry.value,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: AppColors.defaultGrayColor,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildSemesterSection(String title) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: AppColors.primaryColor,
//           ),
//         ),
//         const SizedBox(height: 24),
//         _buildGradesTable(),
//         const SizedBox(height: 12),
//         const Text(
//           'Total Course: 6     GPA: 0     Credit: 18',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             color: AppColors.primaryColor
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildGradesTable() {
//     final headers = ['NO', 'Title', 'Score', 'Credit', 'Grade'];
//     final courses = [
//       ['1', 'Networking Fundamental', '0.00', '3', ''],
//       ['2', 'Introduction to Information and Technology', '0.00', '3', ''],
//       ['3', 'Intensive English Program I', '0.00', '3', ''],
//       ['4', 'Academic Skill Development', '0.00', '3', ''],
//       ['5', 'Multimedia and Web Design', '0.00', '3', ''],
//       ['6', 'Programming Fundamental', '0.00', '3', ''],
//     ];
//
//     return Table(
//       border: TableBorder.all(
//         color: Colors.grey.shade300,
//         width: 1,
//       ),
//       columnWidths: const {
//         0: FlexColumnWidth(0.5),
//         1: FlexColumnWidth(2.5),
//         2: FlexColumnWidth(1),
//         3: FlexColumnWidth(0.8),
//         4: FlexColumnWidth(0.8),
//       },
//       children: [
//         TableRow(
//           decoration: BoxDecoration(
//             color: Colors.grey.shade100,
//           ),
//           children: headers.map((header) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 header,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//         ...courses.map((course) {
//           return TableRow(
//             children: course.map((cell) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   cell,
//                   style: const TextStyle(fontSize: 12),
//                 ),
//               );
//             }).toList(),
//           );
//         }).toList(),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../data/response/status.dart';
import '../../../../model/students_model/achievement_model.dart';
import '../../../../viewModel/students_view_model/achievement_view_model.dart';

class AcheivementScreen extends StatefulWidget {
  const AcheivementScreen({super.key});

  @override
  State<AcheivementScreen> createState() => _AcheivementScreenState();
}

class _AcheivementScreenState extends State<AcheivementScreen> {
  final AchievementViewModel viewModel = AchievementViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.fetchAchievementBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: ChangeNotifierProvider<AchievementViewModel>(
          create: (BuildContext context) => viewModel,
          child: Consumer<AchievementViewModel>(
            builder: (context, value, _) {
              switch (value.achievement.status) {
                case Status.LOADING:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.ERROR:
                  return Center(
                    child: Text(value.achievement.message ?? 'An error occurred'),
                  );
                case Status.COMPLETED:
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildWelcomeBanner(value.achievement.data!),
                        _buildTranscript(value.achievement.data!),
                      ],
                    ),
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner(AchievementModel data) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.fromLTRB(0, 16, 15, 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 130.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, ${data.nameEn}',
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
              backgroundImage: NetworkImage(data.profileImage),
              onBackgroundImageError: (exception, stackTrace) =>
              const AssetImage('assets/images/placeholder.png'),
            ),
          ),
          Positioned(
            top: 95,
            left: 130.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.nameEn,
                  style: const TextStyle(
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranscript(AchievementModel data) {
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
            child: Image.network(
              data.avatar ?? data.profileImage,
              height: 170,
              width: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/tevy1.png',
                height: 170,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 40),
          _buildStudentInfo(data),
          const SizedBox(height: 16),
          _buildSemesterSection('Year 1 Semester 1'),
          const SizedBox(height: 16),
          _buildSemesterSection('Year 1 Semester 2'),
        ],
      ),
    );
  }

  Widget _buildStudentInfo(AchievementModel data) {
    final infoData = {
      'Name (KH)': data.nameKh,
      'Name (EN)': data.nameEn,
      'Date of Birth': "${data.dob.year}-${data.dob.month.toString().padLeft(2, '0')}-${data.dob.day.toString().padLeft(2, '0')}",
      'Degree': data.degree,
      'Major': data.major,
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
              Expanded(
                child: Text(
                  entry.value,
                  style: const TextStyle(
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
  }

  Widget _buildSemesterSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 24),
        _buildGradesTable(),
        const SizedBox(height: 12),
        const Text(
          'Total Course: 6     GPA: 0     Credit: 18',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildGradesTable() {
    final headers = ['NO', 'Title', 'Score', 'Credit', 'Grade'];
    final courses = [
      ['1', 'Networking Fundamental', '0.00', '3', ''],
      ['2', 'Introduction to Information and Technology', '0.00', '3', ''],
      ['3', 'Intensive English Program I', '0.00', '3', ''],
      ['4', 'Academic Skill Development', '0.00', '3', ''],
      ['5', 'Multimedia and Web Design', '0.00', '3', ''],
      ['6', 'Programming Fundamental', '0.00', '3', ''],
    ];

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
        ...courses.map((course) {
          return TableRow(
            children: course.map((cell) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cell,
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