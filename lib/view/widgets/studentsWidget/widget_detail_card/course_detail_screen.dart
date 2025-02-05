import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../model/student_role_model/course_detail_model.dart';
import '../../../../viewModel/student_role_view_model/course_detail_view-model.dart';

class StudentCourseDetailView extends StatefulWidget {
  final String uuid;
  final String token;

  const StudentCourseDetailView({
    super.key,
    required this.uuid,
    required this.token,
  });

  @override
  State<StudentCourseDetailView> createState() => _StudentCourseDetailViewState();
}

class _StudentCourseDetailViewState extends State<StudentCourseDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildDetailItem(String label, String value) {
    return Row(
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderContent(course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Year ${course.year ?? "N/A"}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Semester ${course.semester ?? "N/A"}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          course.courseTitle,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          course.courseDescription,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.defaultGrayColor,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailItem('Credit', course.credit.toString()),
            _buildDetailItem('Theory', course.theory.toString()),
            _buildDetailItem('Practice', course.practice.toString()),
            _buildDetailItem('Internship', course.internship.toString()),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          course.instructor ?? 'Class Start: ${course.classesStart ?? "N/A"}',
          style: const TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 14,
          ),
        ),
        if (course.courseLogo != null)
          Container(
            height: 220,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(course.courseLogo!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, color: Colors.grey),
          ),
          title: Text(
            course.instructor ?? 'Unknown Instructor',
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            course.instructor ?? 'Unknown Instructor',
            style: const TextStyle(
              color: AppColors.defaultGrayColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        StudentCountWidget(
          profileImages: course.studentProfileImage,
        ),
      ],
    );
  }

  Widget _buildCurriculumTab(course) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.courseTitle,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              course.courseDescription,
              style: const TextStyle(
                color: AppColors.defaultGrayColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "What you will learn in this course?",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: course.curriculum.modules.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Icon(
                          Icons.star,
                          color: Color(0xFFEAB305),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          course.curriculum.modules[index].content,
                          style: const TextStyle(
                            color: AppColors.defaultGrayColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentCourseDetailsViewmodel(token: widget.token)
        ..getStudentCourseDetail(widget.uuid),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Course Detail',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
            ),
          ),
        ),
        body: Consumer<StudentCourseDetailsViewmodel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      viewModel.error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          viewModel.getStudentCourseDetail(widget.uuid),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (viewModel.studentCourseDetail == null) {
              return const Center(child: Text('No course details available'));
            }

            final course = viewModel.studentCourseDetail!;

            return NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _buildHeaderContent(course),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.white,
                        unselectedLabelColor: AppColors.defaultGrayColor,
                        indicator: BoxDecoration(
                          color: AppColors.primaryColor, // This matches your image's blue color
                          borderRadius: BorderRadius.circular(8),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        padding: const EdgeInsets.all(4),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                        tabs: [
                          Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: const Text('Curriculum',),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text('Slide'),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text('Video'),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text('Mini Project'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildCurriculumTab(course),
                  const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Course Slide',
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.primaryColor
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Text('All Slide provides an overview of the detailed course. Learn about our mission, values, and what sets us apart.',style: TextStyle(color: AppColors.defaultGrayColor),),
                        ],
                      ),
                    ),
                  ),
                  const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Course Video',
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.primaryColor
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Text('All Video provides an overview of the detailed course. Learn about our mission, values, and what sets us apart.',style: TextStyle(color: AppColors.defaultGrayColor)),
                        ],
                      ),
                    ),
                  ),
                  const SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No mini projects available',style: TextStyle(color: AppColors.defaultGrayColor)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class StudentCountWidget extends StatelessWidget {
  final List<String?> profileImages;
  final double avatarSize;

  const StudentCountWidget({
    Key? key,
    required this.profileImages,
    this.avatarSize = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      leading: SizedBox(
        width: avatarSize * 2.3,
        height: avatarSize * 2.2,
        child: Stack(
          children: [
            for (int i = 0; i < profileImages.length && i < 2; i++)
              Positioned(
                left: i * (avatarSize * 0.6),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: avatarSize / 2,
                    backgroundImage: profileImages[i]?.isNotEmpty == true
                        ? NetworkImage(profileImages[i]!)
                        : null,
                    backgroundColor: Colors.grey[300],
                    child: profileImages[i]?.isEmpty ?? true
                        ? const Icon(Icons.person, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
            if (profileImages.length > 2)
              Positioned(
                left: 3 * (avatarSize * 0.4),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: avatarSize / 2,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      '+${profileImages.length - 2}',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: avatarSize * 0.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      title: Text(
        '${profileImages.length}',
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: const Text(
        'Students Joined',
        style: TextStyle(
          color: AppColors.defaultGrayColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}