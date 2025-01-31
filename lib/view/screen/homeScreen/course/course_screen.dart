import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/data/response/status.dart';
import 'package:lms_mobile/view/Skelaton/homepageSkeleton/coursScreenSkeleton.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/short_course_screen.dart';
import 'package:lms_mobile/viewModel/course_viewmodel.dart';
import 'package:provider/provider.dart';

class ShortCoursePage extends StatefulWidget {
  @override
  State<ShortCoursePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ShortCoursePage> {
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
          icon: const Icon(Icons.arrow_back,color: AppColors.primaryColor,),
        ),
        title: const Text("Courses variable",style: TextStyle(fontSize: 16,color: AppColors.primaryColor)),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: Padding(
          padding: EdgeInsets.only(right: 16,left: 16),
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
                        itemBuilder: (context, index) => CourseScreenSkeleton(),
                      ),
                    );

                  case Status.COMPLETED:
                    final courses = viewModel.course.data?.courseList ?? [];
                    return courses.isEmpty
                        ? Center(child: Text('No courses available'))
                        : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
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
                  case Status.IDLE:
                    throw UnimplementedError();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}