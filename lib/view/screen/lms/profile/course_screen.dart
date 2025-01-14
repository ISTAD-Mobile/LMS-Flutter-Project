import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data/color/color_screen.dart';
import '../../../../data/network/student_role_services/student_course_service.dart';
import '../../../../model/student_role_model/student_course_model.dart';
import '../../../../repository/student_role_repos/student_course_repo.dart';
import '../../../../viewModel/student_role_view_model/student_course_view_model.dart';
import '../../../widgets/studentsWidget/widget_detail_card/course_detail_screen.dart';

class StudentCoursesScreen extends StatelessWidget {
  final String accessToken;

  const StudentCoursesScreen({super.key, required this.accessToken});

  @override
  Widget build(BuildContext context) {
    final service = StudentCoursesService(accessToken: accessToken);
    final repository = StudentCoursesRepository(service: service);
    final viewModel = StudentCoursesViewModel(repository: repository);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Use FutureBuilder to fetch the data and pass it to _buildWelcomeBannerWithData
            FutureBuilder<StudentCoursesModel?>(
              future: viewModel.fetchStudentData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error occurred: Unable to load student data.\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  final data = snapshot.data!;
                  return _buildWelcomeBannerWithData(data);
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
            _buildSearchBar(),
            _buildFilterSection(),
            Expanded(
              child: FutureBuilder<StudentCoursesModel?>(
                future: viewModel.fetchStudentData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error occurred: Unable to load courses.\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    final data = snapshot.data!;
                    if (data.courses.isEmpty) {
                      return const Center(
                        child: Text('No courses available at the moment.'),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: data.courses.length,
                      itemBuilder: (context, index) {
                        final course = data.courses[index];
                        return CourseCard(
                          title: course.title,
                          description: course.description,
                          year: course.year.toString(),
                          semester: course.semester.toString(),
                          credits: course.credit.toString(),
                          thumbnailUrl: course.logo,
                          userProfileUrl:
                              data.profileImage, // Use student's avatar
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 70.0, 20, 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey, width: 0.1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey, width: 0.1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey, width: 0.1),
          ),
          filled: true,
          fillColor: AppColors.defaultWhiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.defaultWhiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
              label: const Text('Filter by semester'),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.defaultWhiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '25',
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildWelcomeBannerWithData(StudentCoursesModel data) {
  return Container(
    margin: const EdgeInsets.all(12.0),
    // Reduced margin
    padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 40),
    // Reduced padding
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back, ${data.nameEn}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16, // Reduced font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ready to take on ${data.courses.length} courses.',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 12, // Reduced top offset
          left: -35,
          child: CircleAvatar(
            radius: 50, // Reduced avatar size
            backgroundImage: NetworkImage(data.profileImage),
          ),
        ),
        Positioned(
          top: 95, // Adjusted position to fit shorter height
          left: 80.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.nameEn}',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16, // Reduced font size
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${data.courses.length} Courses',
                style: const TextStyle(
                  color: AppColors.defaultGrayColor,
                  fontSize: 12, // Reduced font size
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

class CourseCard extends StatelessWidget {
  final String title;
  final String description;
  final String year;
  final String semester;
  final String credits;
  final String thumbnailUrl;
  final String userProfileUrl;

  const CourseCard({
    super.key,
    required this.title,
    required this.description,
    required this.year,
    required this.semester,
    required this.credits,
    required this.thumbnailUrl,
    required this.userProfileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(
              title: title,
              description: description,
              year: year,
              semester: semester,
              credits: credits,
              theory: '',
              practice: '',
            ),
          ),
        );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => CourseDetailScreen(
        //       title: title,
        //       description: description,
        //       year: year,
        //       semester: semester,
        //       credits: credits,
        //       theory: '', // Replace with actual data if available
        //       practice: '', // Replace with actual data if available
        //       thumbnailUrl: thumbnailUrl, // Pass the course image URL
        //     ),
        //   ),
        // );

      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.defaultGrayColor,
                  fontSize: 14, // Reduced font size
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(userProfileUrl),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Year: $year',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Semester: $semester',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'Credits: $credits',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(thumbnailUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
