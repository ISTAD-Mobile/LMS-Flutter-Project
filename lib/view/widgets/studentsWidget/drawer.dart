import 'package:flutter/material.dart';

import '../../../data/color/color_screen.dart';
import '../../home.dart';
import '../../screen/lms/profile/profile_view_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Add a GlobalKey

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Map<String, dynamic>> _widgetOptions = [
    {
      'title': 'profile',
      'page': ProfileScreen(),  // Your CourseScreen widget
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensure height wraps content
          children: [
            AppBar(
              backgroundColor: AppColors.defaultWhiteColor,
              automaticallyImplyLeading: false, // Removes default hamburger icon
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer(); // Use the key to open the drawer
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/tevy.png'),
                      ),
                    ),
                  ),
                  const Spacer(), // Adds space between the CircleAvatar and the logo
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(), // Replace with your page
                        ),
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
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black12, // Replace with your desired color
            ),
          ],
        ),
      ),
      body: const Center(
      ),
      drawer: Drawer(
        backgroundColor: AppColors.defaultWhiteColor,
        child: Column(
          children: [
            Container(
              height: 115,
              padding: const EdgeInsets.fromLTRB(20, 45, 0, 0),
              decoration: const BoxDecoration(
                color: AppColors.defaultWhiteColor,
              ),
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
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0.3,
              thickness: 0.3,
              color: AppColors.primaryColor,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_circle_rounded),
                    iconColor: AppColors.primaryColor,
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    selected: _selectedIndex == 0,
                    onTap: () {
                      _onItemTapped(0);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.collections_bookmark_rounded),
                    iconColor: AppColors.defaultGrayColor,
                    title: const Text(
                      'Course',
                      style: TextStyle(
                        color: AppColors.defaultGrayColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    selected: _selectedIndex == 1,
                    onTap: () {
                      _onItemTapped(1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    iconColor: AppColors.defaultGrayColor,
                    title: const Text(
                      'Achievement',
                      style: TextStyle(
                        color: AppColors.defaultGrayColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    selected: _selectedIndex == 2,
                    onTap: () {
                      _onItemTapped(2);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    iconColor: AppColors.defaultGrayColor,
                    title: const Text(
                      'Setting',
                      style: TextStyle(
                        color: AppColors.defaultGrayColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    selected: _selectedIndex == 3,
                    onTap: () {
                      _onItemTapped(3);
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(
                    height: 0.3,
                    thickness: 0.3,
                    color: AppColors.primaryColor,
                  ),
                  ListTile(
                    iconColor: AppColors.secondaryColor,
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      'Sign Out',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      // Add your logout logic here
                      Navigator.pop(context);
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
