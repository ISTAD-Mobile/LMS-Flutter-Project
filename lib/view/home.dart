import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/academic/my_home_academic_screen.dart';
import 'package:lms_mobile/view/screen/lms/auth/first_log_in_screen.dart';
import 'package:lms_mobile/view/widgets/about_tapbar_navigation_widget.dart';
import 'package:lms_mobile/view/widgets/academict_ype_and_scholarship.dart';
import 'package:lms_mobile/view/widgets/appbar_and_bottom_navigation_widgets.dart';
import 'package:lms_mobile/view/widgets/istad_activity.dart';
import 'package:lms_mobile/view/widgets/video_background.dart';

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
      'page': ListView( // Use ListView for scrollable content
        children: const [
          VideoBackground(),
          IstadActivity(),
          AcademicTypeAndScholarshipWidget(),
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
