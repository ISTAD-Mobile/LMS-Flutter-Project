import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import '../../screen/about/about_my_director_screen.dart';
import '../../screen/about/about_our_team_screen.dart';
import '../../screen/about/my_home_about_istad_screen.dart';

class AboutTapbarNavigation extends StatefulWidget {
  const AboutTapbarNavigation({super.key});

  @override
  _TabNavigationScreenState createState() => _TabNavigationScreenState();
}

class _TabNavigationScreenState extends State<AboutTapbarNavigation> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            // padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.defaultWhiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorPadding: EdgeInsets.zero,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicatorColor:Colors.blue,
              tabs: const [
                Tab(text: 'About ISTAD'),
                Tab(text: 'My Director'),
                Tab(text: 'Our Team'),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const HomeIstadScreen(),
                DirectorScreen(),
                OurTeamScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






