import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/data/response/status.dart';
import 'package:lms_mobile/view/Skelaton/homepageSkeleton/coursScreenSkeleton.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/short_course_screen.dart';
import 'package:lms_mobile/viewModel/course_viewmodel.dart';
import 'package:provider/provider.dart';

  const CourseCard({Key? key, required this.coursePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsPage(),
          ),
        );
      },
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: Colors.grey.shade400),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.network(
                  coursePage.imageUrl,
                  width: 85,
                  height: 85,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: coursePage.title.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: [
                          const TextSpan(
                            text: '\n ',
                            style: TextStyle(
                              color: Colors.transparent,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      coursePage.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.defaultGrayColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/128/3240/3240587.png',
                              width: 16,
                              height: 16,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              coursePage.duration,
                              style: TextStyle(
                                color: AppColors.defaultGrayColor,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/256/17009/17009106.png',
                              width: 16,
                              height: 16,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              coursePage.level,
                              style: TextStyle(
                                color: AppColors.defaultGrayColor,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          coursePage.scholarship,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.defaultWhiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
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





