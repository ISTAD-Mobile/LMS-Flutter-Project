import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../data/network/student_role_services/student_course_service.dart';
import '../../../../model/student_role_model/student_course_model.dart';
import '../../../../repository/student_role_repos/student_course_repo.dart';
import '../../../../viewModel/student_role_view_model/student_course_view_model.dart';
import '../../../widgets/studentsWidget/widget_detail_card/course_detail_screen.dart';

class StudentCoursesScreen extends StatefulWidget {
  final String token;

  const StudentCoursesScreen({super.key, required this.token});

  @override
  _StudentCoursesScreenState createState() => _StudentCoursesScreenState();
}

class _StudentCoursesScreenState extends State<StudentCoursesScreen> {
  late StudentCoursesViewModel viewModel;
  TextEditingController searchController = TextEditingController();
  TextEditingController itemsPerPageController = TextEditingController(text: '25');
  String searchQuery = '';
  String? selectedSemester;
  final List<String> semesters = ['1', '2'];
  int itemsPerPage = 25;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    final service = StudentCoursesService(token: widget.token);
    final repository = StudentCoursesRepository(service: service);
    viewModel = StudentCoursesViewModel(repository: repository);
  }

  void _resetFilter() {
    setState(() {
      selectedSemester = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
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
            Expanded(child: _buildCoursesList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 70.0, 20, 20),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search for courses',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey, width: 0.1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey, width: 0.1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey, width: 0.1),
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
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.defaultWhiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton<String>(
                  color: AppColors.defaultWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  offset: const Offset(0, 40),
                  constraints: const BoxConstraints(
                    minWidth: 200,
                    maxWidth: 200,
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      enabled: false,
                      height: 65,
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Filter Semester...',
                            prefixIcon: const Icon(Icons.search, size: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 2,
                            )
                          ),
                        ),
                      ),
                    ),
                    ...semesters.map((semester) => PopupMenuItem<String>(
                      value: semester,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedSemester == semester
                              ? Colors.grey.shade50
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('$semester'),
                      ),
                    )),
                    const PopupMenuItem<String>(
                      value: 'reset',
                      height: 40,
                      child: Center(
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                            fontSize: 16
                          ),
                        ),
                      ),
                    ),
                  ],
                  onSelected: (String value) {
                    if (value == 'reset') {
                      _resetFilter();
                    } else {
                      setState(() {
                        selectedSemester = value;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.filter_alt_outlined,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          selectedSemester ?? 'Filter by semester',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.defaultWhiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SizedBox(
                width: 50,
                child: TextField(
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  controller: itemsPerPageController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      itemsPerPage = int.tryParse(value) ?? 25;
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCoursesList() {
    return FutureBuilder<StudentCoursesModel?>(
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
          var filteredCourses = data.courses
              .where((course) =>
                  course.title.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList();

          // Apply semester filter if selected
          if (selectedSemester != null) {
            filteredCourses = filteredCourses
                .where((course) => course.semester.toString() == selectedSemester)
                .toList();
          }

          if (filteredCourses.isEmpty) {
            return const Center(
              child: Text('No courses available for the selected filters.'),
            );
          }

          final startIndex = (currentPage - 1) * itemsPerPage;
          final endIndex = startIndex + itemsPerPage;
          final paginatedCourses = filteredCourses.sublist(
            startIndex,
            endIndex > filteredCourses.length ? filteredCourses.length : endIndex,
          );

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: paginatedCourses.length,
            itemBuilder: (context, index) {
              final course = paginatedCourses[index];
              return CourseCard(
                title: course.title,
                description: course.description,
                year: course.year.toString(),
                semester: course.semester.toString(),
                credits: course.credit.toString(),
                thumbnailUrl: course.logo,
                userProfileUrl: data.profileImage,
              );
            },
          );
        } else {
          return const Center(
            child: Text('No data available'),
          );
        }
      },
    );
  }
}

Widget _buildWelcomeBannerWithData(StudentCoursesModel data) {
  return Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 40),
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
          top: 15, // Reduced top offset
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
              thumbnailUrl: thumbnailUrl,
            ),
          ),
        );
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