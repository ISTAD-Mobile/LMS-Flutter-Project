import 'package:flutter/material.dart';

import '../../../../data/color/color_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String year;
  final String semester;
  final String credits;
  final String theory;
  final String practice;

  const CourseDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.year,
    required this.semester,
    required this.credits,
    required this.theory,
    required this.practice,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Year and Semester Tags
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Year ${widget.year}',
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
                          'Semester ${widget.semester}',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Course Description
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.defaultGrayColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Course Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailItem('Credit', widget.credits),
                      _buildDetailItem('Theory', widget.theory),
                      _buildDetailItem('Practice', widget.practice),
                      _buildDetailItem('Internship', 'N/A'),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Class Start Date
                  const Text(
                    "Class Start: 11/02/2002",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.defaultGrayColor,
                    ),
                  ),

                  // Course Image Placeholder
                  Container(
                    height: 220,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, size: 48, color: Colors.grey),
                  ),

                  // Instructor Info
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                    title: const Text(
                      'Unknown Instructor',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text(
                      'Unknown Instructor',
                      style: TextStyle(
                        color: AppColors.defaultGrayColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  // Students Count
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.group, color: Colors.grey),
                    ),
                    title: const Text(
                      '1',
                      style: TextStyle(
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
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'Curriculum'),
                  Tab(text: 'Slide'),
                  Tab(text: 'Video'),
                  Tab(text: 'Mini Project'),
                ],
              ),
            ),

            // Tab Bar View
            SizedBox(
              height: 300, // Set a fixed height for TabBarView
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: Text('No data of curriculum')),
                  Center(child: Text('No slides available')),
                  Center(child: Text('No videos available')),
                  Center(child: Text('No mini projects available')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Row(
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
