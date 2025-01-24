import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<StudentCoursesModel?>(
                future: viewModel.fetchStudentData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildWelcomeBannerSkeleton();
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
              _buildCoursesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16, 16),
      child: Container(
        height: 40,
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search for courses',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),
            prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.grey, width: 0.1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.grey, width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.grey, width: 0.1),
            ),
            filled: true,
            fillColor: AppColors.defaultWhiteColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          ),
        ),
      ),
    );
  }


  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
            decoration: BoxDecoration(
              color: AppColors.defaultWhiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SizedBox(
              width: 50,
              child: TextField(
                controller: itemsPerPageController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                onSubmitted: (value) {
                  setState(() {
                    itemsPerPage = int.tryParse(value) ?? 25;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesList() {
    return FutureBuilder<StudentCoursesModel?>(
      future: viewModel.fetchStudentData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildCoursesListSkeleton();
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
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(13),
            itemCount: paginatedCourses.length,
            itemBuilder: (context, index) {
              final course = paginatedCourses[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CourseCard(
                  title: course.title,
                  description: course.description,
                  year: course.year.toString(),
                  semester: course.semester.toString(),
                  credits: course.credit.toString(),
                  thumbnailUrl: course.logo,
                  userProfileUrl: data.profileImage != null && data.profileImage!.isNotEmpty
                      ? data.profileImage
                      : 'assets/images/placeholder.jpg',
                ),
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
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.fromLTRB(0, 16, 15, 16),
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Text content inside the banner
        Padding(
          padding: const EdgeInsets.only(left: 115.0),
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
              Text(
                'Passionate about literature and creative writing.',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13, // Adjusted font size to match the new style
                ),
              ),
            ],
          ),
        ),
        // Positioned Circle Avatar
        Positioned(
          top: 30,
          left: 0,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200], // Placeholder color
            foregroundImage: data.profileImage != null &&
                data.profileImage!.isNotEmpty
                ? NetworkImage(data.profileImage!)
                : null,
            child: data.profileImage == null ||
                data.profileImage!.isEmpty
                ? Image.asset('assets/images/placeholder.jpg')
                : null,
          ),
        ),
        // Display the name and courses
        Positioned(
          top: 95, // Adjusted to provide space below the avatar
          left: 115.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.nameEn,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${data.courses.length} Courses',
                style: const TextStyle(
                  color: AppColors.defaultGrayColor,
                  fontSize: 12, // Adjusted font size
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
                    backgroundColor: userProfileUrl == null || userProfileUrl.isEmpty
                        ? Colors.grey[200]
                        : null,
                    foregroundImage: userProfileUrl != null && userProfileUrl.isNotEmpty
                        ? NetworkImage(userProfileUrl)
                        : null,
                    child: userProfileUrl == null || userProfileUrl.isEmpty
                        ? Image.asset('assets/images/placeholder.jpg')
                        : null,
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



Widget _buildWelcomeBannerSkeleton() {
  return Container(
    height: 100,
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.fromLTRB(0, 16, 15, 16),
    decoration: BoxDecoration(
      color: AppColors.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Placeholder for text content inside the banner
        Padding(
          padding: const EdgeInsets.only(left: 115.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for 'Welcome back'
              Container(
                height: 16,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              // Placeholder for tagline text
              Container(
                height: 12,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
        // Placeholder for Circle Avatar
        Positioned(
          top: 30,
          left: 0,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white.withOpacity(0.3),
          ),
        ),
        // Placeholder for name and courses
        Positioned(
          top: 95,
          left: 115.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16,
                width: 150,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 12,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.defaultGrayColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCoursesListSkeleton() {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(13),
    itemCount: 5, // Number of skeleton items to show
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Placeholder
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 18,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 10),
                      // Description Placeholder
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 14,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 10),
                      // Details Placeholder
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey[300],
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 60,
                                  height: 14,
                                  color: Colors.grey[300],
                                ),
                                Container(
                                  width: 50,
                                  height: 14,
                                  color: Colors.grey[300],
                                ),
                                Container(
                                  width: 40,
                                  height: 14,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Thumbnail Placeholder
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


