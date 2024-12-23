import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/register/register_step_1.dart';
import '../../../data/color/color_screen.dart';

class MyAppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.defaultWhiteColor,
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppLayout(
        title: 'Your App Title',
        body: Container(
          color: AppColors.defaultWhiteColor,
        ),
        currentIndex: 0,
        onTabTapped: (int index) {},
      ),
    );
  }
}

class AppLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onTabTapped;

  const AppLayout({
    Key? key,
    required this.title,
    required this.body,
    required this.currentIndex,
    required this.onTabTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: currentIndex == 3 ? null : _buildAppBar(context),
      body: body,
      bottomNavigationBar: currentIndex == 3 ? null : _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              'assets/images/istad-logo-white.png',
              height: 37,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          _buildAdmissionButton(context),
        ],
      ),
    );
  }

  ElevatedButton _buildAdmissionButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterStep1(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        minimumSize: const Size(120, 33),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            'https://cdn-icons-png.flaticon.com/128/684/684872.png',
            width: 18,
            height: 18,
            color: Colors.white,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 4),
          const Text(
            'ADMISSION',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.defaultGrayColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
      ),
      backgroundColor: AppColors.defaultWhiteColor,
      items: _bottomNavItems(),
    );
  }

  List<BottomNavigationBarItem> _bottomNavItems() {
    return [
      _buildBottomNavItem(
        'https://cdn-icons-png.flaticon.com/128/69/69524.png',
        'Home',
        iconSize: 24,
      ),
      _buildBottomNavItem(
        'https://cdn-icons-png.flaticon.com/256/17278/17278445.png',
        'Academic',
        iconSize: 30,
      ),
      _buildBottomNavItem(
        'https://cdn-icons-png.flaticon.com/128/17701/17701943.png',
        'About',
        iconSize: 28,
      ),
      _buildBottomNavItem(
        'https://cdn-icons-png.flaticon.com/128/552/552721.png',
        'LMS',
        iconSize: 22,
      ),
    ];
  }

  BottomNavigationBarItem _buildBottomNavItem(String imageUrl, String label, {double iconSize = 22.0}) {
    return BottomNavigationBarItem(
      icon: _buildNavIcon(imageUrl, AppColors.defaultGrayColor, iconSize),
      activeIcon: _buildNavIcon(imageUrl, AppColors.primaryColor, iconSize),
      label: label,
    );
  }

  Widget _buildNavIcon(String imageUrl, Color color, double iconSize) {
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}




