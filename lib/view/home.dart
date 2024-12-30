import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/academic/my_home_academic_screen.dart';
import 'package:lms_mobile/view/screen/lms/auth/log_in_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/about_tapbar_navigation_widget.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/academic_type_and_scholarship.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/appbar_and_bottom_navigation_widgets.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/bachelor_program.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/courosel_student_cart.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/course_section.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/istad_activity.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/it_news/it_news_section.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/project_archeivement_section.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/video_background.dart';
import 'package:lms_mobile/view/widgets/studentsWidget/drawer.dart';
import 'package:lms_mobile/viewModel/course_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/color/color_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final courseViewModel = CourseViewmodel();
  int _selectedIndex = 0;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    courseViewModel.fetchAllBlogs(); // Fetch blogs
  }

  Future<void> _checkLoginStatus() async {
    final accessToken = await _storage.read(key: 'accessToken');
    if (accessToken == null || accessToken.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen()),
      );
    } else {
      // Token exists, check if it's valid
      // You can add your token validation logic here (e.g., call an API to check token validity)
      // For now, we'll assume the token is valid if it exists
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StudentScreen(title: 'Course')),
      );
    }
  }

  // Method to open Telegram link
  Future<void> _openTelegram() async {
    const telegramUrl = "https://t.me/istadkh";
    if (await canLaunch(telegramUrl)) {
      await launch(telegramUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Telegram')),
      );
    }
  }

  // Pages list
  final List<Map<String, dynamic>> _tabs = [
    {
      'title': 'Home',
      'page': ListView(
        children: [
          const VideoBackground(),
          const IstadActivity(),
          const AcademicTypeAndScholarshipWidget(),
          CourseSection(),
          const ItNewsSection(),
          ProjectArcheivementHome(),
          BachelorProgramHome(),
          Container(
            height: 430,
            child: const TestimonialPage(),
          ),
        ],
      ),
    },
    {
      'title': 'Academic',
      'page': const MyAcademicScreen(),
    },
    {
      'title': 'About',
      'page': AboutTapbarNavigation(),
    },
    {
      'title': 'LMS',
      'page': const LogInScreen(),
    },
  ];

  // Tab change handler
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 3) { // LMS tab
      _checkLoginStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: _tabs[_selectedIndex]['title'] as String,
      body: Stack(
        children: [
          _tabs[_selectedIndex]['page'] as Widget,
          if (_selectedIndex == 0)
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: _openTelegram,
                child: ClipOval(
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/256/2840/2840156.png',
                    width: 30,
                    height: 30,
                    color: AppColors.defaultWhiteColor,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
      currentIndex: _selectedIndex,
      onTabTapped: _onItemTapped,
    );
  }
}
