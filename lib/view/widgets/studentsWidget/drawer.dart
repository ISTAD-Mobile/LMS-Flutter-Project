
import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/lms/profile/course_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/color/color_screen.dart';
import '../../../repository/student_profile_repository.dart';
import '../../../viewModel/student_profile_viewModel.dart';
import '../../home.dart';
import '../../screen/lms/profile/acheivement_screen.dart';
import '../../screen/lms/profile/profile_view_screen.dart';
import '../../screen/lms/profile/settings/static_profile_setting_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: StudentScreen(title: appTitle, accessToken: ''),
    );
  }
}

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key, required this.title, required  this.accessToken});

  final String title;
  final String accessToken;

  @override
  State<StudentScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StudentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  late String accessToken;


  List<Map<String, dynamic>> _pages = [];

  @override
  void initState() {
    super.initState();
    accessToken = widget.accessToken;
    _initializePages();
  }

  void _initializePages() {
    setState(() {
      _pages = [
        {'title': 'Profile', 'widget': ProfileScreen(accessToken: accessToken)},
        {'title': 'Course', 'widget': CourseScreen(accessToken: accessToken)},
        {'title': 'Achievement', 'widget': AcheivementScreen(accessToken: accessToken,)},
        {'title': 'Setting', 'widget': StaticProfileViewScreen(accessToken: accessToken)},
      ];
    });
  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  Widget _buildDrawerListTile({
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    final isSignOut = title == 'Sign Out';
    return ListTile(
      leading: Icon(
        icon,
        color: isSignOut
            ? AppColors.secondaryColor
            : (selected ? AppColors.primaryColor : AppColors.defaultGrayColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSignOut
              ? AppColors.secondaryColor
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
    if (_pages == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 2,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
                child: ChangeNotifierProvider(
                  create: (_) => StudenProfileDataViewModel(
                    userRepository: StudentProfileRepository(accessToken: accessToken),
                  ),
                  child: Consumer<StudenProfileDataViewModel>(
                    builder: (context, viewModel, _) {

                      if (viewModel.user == null && !viewModel.isLoading && viewModel.errorMessage == null) {
                        viewModel.fetchUserData();
                      }

                      if (viewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (viewModel.errorMessage != null) {
                        return Center(child: Text("Error: ${viewModel.errorMessage}"));
                      } else if (viewModel.user == null) {
                        return const Center(child: Text("No user data found"));
                      } else {
                        final user = viewModel.user!;
                        return CircleAvatar(
                          radius: 22,
                          backgroundImage: user.profileImage != null && user.profileImage!.isNotEmpty
                              ? NetworkImage(user.profileImage!)
                              : const AssetImage('assets/images/placeholder.jpg'),
                        );
                      }
                    },
                  ),
                ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {

                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('accessToken', accessToken);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
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
            ChangeNotifierProvider(
            create: (_) => StudenProfileDataViewModel(userRepository: StudentProfileRepository(accessToken: accessToken)),
              child: Consumer<StudenProfileDataViewModel>(
              builder: (context, viewModel, _) {
              // Trigger fetch user data if needed
              if (viewModel.user == null && !viewModel.isLoading && viewModel.errorMessage == null) {
              viewModel.fetchUserData();
              }
              if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
              } else if (viewModel.errorMessage != null) {
              return Center(child: Text("Error: ${viewModel.errorMessage}"));
              } else if (viewModel.user == null) {
              return const Center(child: Text("No user data found"));
              } else {
              final user = viewModel.user!;
              return Container(
              height: 115,
              padding: const EdgeInsets.fromLTRB(20, 45, 0, 0),
              color: AppColors.defaultWhiteColor,
              child: Row(
              children: [
                CircleAvatar(
                radius: 22,
                backgroundImage: user.profileImage != null  && user.profileImage!.isNotEmpty
                    ? NetworkImage(user.profileImage!)
                    : const AssetImage('assets/images/placeholder.jpg') as ImageProvider,
              ),
              const SizedBox(width: 16),
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
              user.nameEn,
              style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              ),
              ),
              Text(
                user.degree,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              ],
              ),
              ],
              ),
              );
              }
              },
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
                    selected: _selectedIndex == 0,
                    onTap: () => _onItemTapped(0),
                  ),
                  _buildDrawerListTile(
                    icon: Icons.collections_bookmark_rounded,
                    title: 'Course',
                    selected: _selectedIndex == 1,
                    onTap: () => _onItemTapped(1),
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
                    onTap: () async {
                      try {
                        // Clear the access token from SharedPreferences
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('accessToken');

                        // Navigate to the Login screen (or HomeScreen if you want)
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()), // Use LoginScreen instead of HomeScreen
                        );
                      } catch (error) {
                        // If there is an error, show a snack bar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to sign out. Please try again.')),
                        );
                      }
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