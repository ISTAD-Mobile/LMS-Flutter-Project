import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/data/response/status.dart';
import 'package:lms_mobile/model/course.dart';
import 'package:lms_mobile/view/Skelaton/homepageSkeleton/courseCardSkeleton.dart';
import 'package:lms_mobile/view/screen/homeScreen/course/course_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/short_course_card.dart';
import 'package:lms_mobile/viewModel/course_viewmodel.dart';
import 'package:provider/provider.dart';


// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => CourseViewmodel(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false, // Disable the debug banner
//         title: 'Course App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: CourseSection(), // Start the app with the CourseSection widget
//       ),
//     );
//   }
// }

class CourseSection extends StatefulWidget {

  @override
  State<CourseSection> createState() => _CourseSectionState();
}

class _CourseSectionState extends State<CourseSection> {
  final courseViewModel = CourseViewmodel();

  @override
  void initState() {
    super.initState();
    courseViewModel.fetchAllBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Short Course'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CourseVerticalListPage(),
                    ),
                  );
                },
                child: const Text(
                  'See More',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Provide a fixed height for the ListView.builder
          ChangeNotifierProvider(
            create: (context) => courseViewModel,
            child: Consumer<CourseViewmodel>(
              builder: (context, viewModel, _) {
                switch (viewModel.course.status!) {
                  case Status.LOADING:
                    return SizedBox(
                      height: 200, // Fixed height for loading
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) => ShortCourseCardSkeleton(),
                      ),
                    );

                  case Status.COMPLETED:
                    final courses = viewModel.course.data?.dataList ?? [];
                    return courses.isEmpty
                        ? Center(child: Text('No courses available'))
                        : SizedBox(
                      height: 200, // Fixed height for the course list
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          final course = courses[index];
                          return ShortCourseCard(course);
                        },
                      ),
                    );

                  case Status.ERROR:
                    return Center(
                      child: Text(
                        'An error occurred: ${viewModel.course.message}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

