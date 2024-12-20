import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/data/response/status.dart';
import 'package:lms_mobile/view/Skelaton/homepageSkeleton/coursScreenSkeleton.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/short_course_screen.dart';
import 'package:lms_mobile/viewModel/course_viewmodel.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatefulWidget {
  @override
  State<CourseScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CourseScreen> {
  final courseViewModel = CourseViewmodel();

  @override
  void initState() {
    super.initState();
    courseViewModel.fetchAllBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Back",style: TextStyle(fontSize: 20,color: AppColors.defaultGrayColor)),
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: ChangeNotifierProvider(
          create: (context) => courseViewModel,
          child: Consumer<CourseViewmodel>(
            builder: (context, viewModel, _) {
              switch (viewModel.course.status!) {
                case Status.LOADING:
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (context, index) => Coursscreenskeleton(),
                    ),
                  );

                case Status.COMPLETED:
                  final courses = viewModel.course.data?.dataList ?? [];
                  return courses.isEmpty
                      ? Center(child: Text('No courses available'))
                      : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: ShortCourseScreen(course),
                      );
                    },
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
      ),
    );
  }
}