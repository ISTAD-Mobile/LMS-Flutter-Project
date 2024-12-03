import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/academic/my_home_academic_screen.dart';
import 'package:lms_mobile/view/screen/lms/auth/first_log_in_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/about_tapbar_navigation_widget.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/academic_type_and_scholarship.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/appbar_and_bottom_navigation_widgets.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/istad_activity.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/short_course_card.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/video_background.dart';

import '../data/color/color_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Home',
      'page': ListView(
        children: [
          const VideoBackground(),
          const IstadActivity(),
          const AcademicTypeAndScholarshipWidget(),
          // Short Courses section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and "See More" Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Short Course'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Text(
                      'see more',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Horizontal scrolling list of ShortCourseCard
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ShortCourseCard(width: 250),  // Provide width for each card
                      SizedBox(width: 10),
                      ShortCourseCard(width: 250),
                      SizedBox(width: 10),
                      ShortCourseCard(width: 250),
                      SizedBox(width: 10),
                      ShortCourseCard(width: 250),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    },
    {
      'title': 'Academic',
      'page': MyAcademicScreen(),
    },
    {
      'title': 'About',
      'page': AboutTapbarNavigation(),
    },
    {
      'title': 'LMS',
      'page': firstSignInScreen(),
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: _pages[_selectedIndex]['title'] as String,
      body: _pages[_selectedIndex]['page'] as Widget,
      currentIndex: _selectedIndex,
      onTabTapped: _onItemTapped,
    );
  }
}
