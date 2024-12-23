// import 'package:flutter/material.dart';
// import 'package:lms_mobile/view/screen/academic/my_home_academic_screen.dart';
// import 'package:lms_mobile/view/screen/lms/auth/log_in_screen.dart';
// import 'package:lms_mobile/view/widgets/public_screen_widgets/about_tapbar_navigation_widget.dart';
// import 'package:lms_mobile/view/widgets/public_screen_widgets/home/academic_type_and_scholarship.dart';
// import 'package:lms_mobile/view/widgets/public_screen_widgets/appbar_and_bottom_navigation_widgets.dart';
// import 'package:lms_mobile/view/widgets/public_screen_widgets/home/bachelor_program.dart';
// import 'package:lms_mobile/view/widgets/public_screen_widgets/home/courosel_student_cart.dart';
// import 'package:lms_mobile/view/widgets/public_screen_widgets/home/course_section.dart';
// import 'package:lms_mobile/view/widgets/public_screen_widgets/home/istad_activity.dart';
// import 'package:lms_mobile/view/widgets/public_screen_widgets/home/it_news/it_news_section.dart';
// import 'package:lms_mobile/view/widgets/public_screen_widgets/home/project_archeivement_section.dart';
// import 'package:lms_mobile/view/widgets/public_screen_widgets/home/video_background.dart';
// import 'package:lms_mobile/viewModel/course_viewmodel.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../data/color/color_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final courseViewModel = CourseViewmodel();
//   int _selectedIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     courseViewModel.fetchAllBlogs();
//   }
//
//   final List<Map<String, dynamic>> _pages = [
//     {
//       'title': 'Home',
//       'page': ListView(
//         children: [
//           const VideoBackground(),
//           const IstadActivity(),
//           const AcademicTypeAndScholarshipWidget(),
//           CourseSection(),
//           const ItNewsSection(),
//           ProjectArcheivementHome(),
//           BachelorProgramHome(),
//           Container(
//             height: 430,
//             child: const TestimonialPage(),
//           ),
//         ],
//       ),
//     },
//     {
//       'title': 'Academic',
//       'page': const MyAcademicScreen(),
//     },
//     {
//       'title': 'About',
//       'page': AboutTapbarNavigation(),
//     },
//     {
//       'title': 'LMS',
//       'page': const LogInScreen(),
//     },
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AppLayout(
//       title: _pages[_selectedIndex]['title'] as String,
//       body: Stack(
//         children: [
//           _pages[_selectedIndex]['page'] as Widget,
//           if (_selectedIndex == 0)
//             Positioned(
//               bottom: 16,
//               right: 16,
//               child: FloatingActionButton(
//                 backgroundColor: AppColors.primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: ClipOval(
//                   child: Image.network(
//                     'https://cdn-icons-png.flaticon.com/256/2840/2840156.png',
//                     width: 30,
//                     height: 30,
//                     color: AppColors.defaultWhiteColor,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 onPressed: () async {
//                   const telegramUrl = "https://t.me/istadkh";
//                   if (await canLaunch(telegramUrl)) {
//                     await launch(telegramUrl);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Could not open Telegram')),
//                     );
//                   }
//                 },
//               ),
//             ),
//         ],
//       ),
//       currentIndex: _selectedIndex,
//       onTabTapped: _onItemTapped,
//     );
//   }
// }

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
import 'package:lms_mobile/viewModel/course_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/color/color_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final courseViewModel = CourseViewmodel();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    courseViewModel.fetchAllBlogs(); // Fetch blogs
  }

  final List<Map<String, dynamic>> _pages = [
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: _pages[_selectedIndex]['title'] as String,
      body: Stack(
        children: [
          _pages[_selectedIndex]['page'] as Widget,
          if (_selectedIndex == 0)
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/256/2840/2840156.png',
                    width: 30,
                    height: 30,
                    color: AppColors.defaultWhiteColor,
                    fit: BoxFit.cover,
                  ),
                ),
                onPressed: () async {
                  const telegramUrl = "https://t.me/istadkh";
                  if (await canLaunch(telegramUrl)) {
                    await launch(telegramUrl);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not open Telegram')),
                    );
                  }
                },
              ),
            ),
        ],
      ),
      currentIndex: _selectedIndex,
      onTabTapped: _onItemTapped,
    );
  }
}
