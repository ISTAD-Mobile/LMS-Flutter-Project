import 'package:flutter/material.dart';
import 'package:lms_mobile/viewModel/student_role_view_model/course_detail_view-model.dart';
import 'package:provider/provider.dart';
import '../../../../model/student_role_model/course_detail_model.dart';

class StudentCoursesDetailsScreen extends StatefulWidget {
  final String courseUuid;
  final String token;
  const StudentCoursesDetailsScreen({super.key, required this.courseUuid,required this.token});

  @override
  _StudentCoursesScreenState createState() => _StudentCoursesScreenState();
}

class _StudentCoursesScreenState extends State<StudentCoursesDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<StudentCourseDetailsViewModel>(context, listen: false)
          .getCourseDetails(widget.courseUuid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Courses')),
      body: Consumer<StudentCourseDetailsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text('Error: ${viewModel.errorMessage}'));
          } else if (viewModel.course == null) {
            return const Center(child: Text('No data available'));
          } else {
            final StudentCourseDetailModel data = viewModel.course!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.courseTitle,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(data.courseDescription),
                  const SizedBox(height: 10),
                  if (data.courseLogo.isNotEmpty)
                    Image.network(data.courseLogo, height: 100),
                  const SizedBox(height: 10),
                  Text('Year: ${data.year} Semester: ${data.semester}'),
                  Text(
                      'Credit: ${data.credit}  Theory: ${data.theory}  Practice: ${data.practice}  Internship: ${data.internship}'),
                  const SizedBox(height: 10),
                  if (data.instructor != null && data.position != null)
                    Text('Instructor: ${data.instructor} (${data.position})'),
                  const SizedBox(height: 10),
                  const Text('Curriculum Modules:',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.curriculumModules.length,
                      itemBuilder: (context, index) {
                        final module = data.curriculumModules[index];
                        return ListTile(
                          title: Text(module.title),
                          subtitle: Text(module.content),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
