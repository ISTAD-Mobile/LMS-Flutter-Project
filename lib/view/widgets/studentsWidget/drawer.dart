import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/lms/profile/course_screen.dart';
import '../../../data/color/color_screen.dart';
import '../../home.dart';
import '../../screen/lms/profile/acheivement_screen.dart';
import '../../screen/lms/profile/profile_view_screen.dart';
import '../../screen/lms/profile/settings/static_profile_setting_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: StudentScreen(title: appTitle),
    );
  }
}

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key, required this.title});

  final String title;

  @override
  State<StudentScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StudentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {'title': 'Course', 'widget': const CourseScreen()},
    {'title': 'Profile', 'widget': const ProfileScreen()},
    {'title': 'Achievement', 'widget': const AcheivementScreen()},
    {'title': 'Setting', 'widget': const StaticProfileViewScreen()},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer on item tap
  }

  Widget _buildDrawerListTile({
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    // Check if it's the Sign Out item based on the title
    final isSignOut = title == 'Sign Out';

    return ListTile(
      // leading: Icon(icon, color: selected ? AppColors.primaryColor : AppColors.defaultGrayColor),
      // title: Text(
      //   title,
      //   style: TextStyle(
      //     color: selected ? AppColors.primaryColor : textColor ?? AppColors.defaultGrayColor,
      //     fontSize: 18,
      //     fontWeight: FontWeight.w400,
      //   ),
      // ),
      // selected: selected,
      // onTap: onTap,
      leading: Icon(
          icon,
          color: isSignOut
              ? AppColors.secondaryColor  // Use secondaryColor for Sign Out
              : (selected ? AppColors.primaryColor : AppColors.defaultGrayColor)
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSignOut
              ? AppColors.secondaryColor  // Use secondaryColor for Sign Out
              : (selected ? AppColors.primaryColor : AppColors.defaultGrayColor),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 2, // This adds a subtle shadow
        scrolledUnderElevation: 2, // This maintains the shadow when scrolling
        surfaceTintColor: Colors.transparent, // This prevents color change on scroll
        shadowColor: Colors.black.withOpacity(0.1), // This controls shadow color
        title: Row(
          children: [
            GestureDetector(
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/tevy.png'),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Image.asset(
                'assets/images/logo_log_in.png',
                height: 35,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),

      body: _pages[_selectedIndex]['widget'] as Widget,
      drawer: Drawer(
        backgroundColor: AppColors.defaultWhiteColor,
        child: Column(
          children: [
            Container(
              height: 115,
              padding: const EdgeInsets.fromLTRB(20, 45, 0, 0),
              color: AppColors.defaultWhiteColor,
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/images/tevy.png'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mi sorakmony',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'STUDENT',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.primaryColor, thickness: 0.3),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerListTile(
                    icon: Icons.account_circle_rounded,
                    title: 'Profile',
                    selected: _selectedIndex == 1,
                    onTap: () => _onItemTapped(1),
                  ),
                  _buildDrawerListTile(
                    icon: Icons.collections_bookmark_rounded,
                    title: 'Course',
                    selected: _selectedIndex == 0,
                    onTap: () => _onItemTapped(0),
                  ),
                  _buildDrawerListTile(
                    icon: Icons.account_balance_wallet,
                    title: 'Achievement',
                    selected: _selectedIndex == 2,
                    onTap: () => _onItemTapped(2),
                  ),
                  _buildDrawerListTile(
                    icon: Icons.settings,
                    title: 'Setting',
                    selected: _selectedIndex == 3,
                    onTap: () => _onItemTapped(3),
                  ),
                  const Divider(color: AppColors.primaryColor, thickness: 0.3),
                  _buildDrawerListTile(
                    icon: Icons.logout,
                    title: 'Sign Out',
                    selected: false,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
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
