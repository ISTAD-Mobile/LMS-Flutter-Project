import 'package:flutter/material.dart';
import '../../screen/about/about_my_director_screen.dart';
import '../../screen/about/about_our_team_screen.dart';
import '../../screen/about/my_home_about_istad_screen.dart';
import '../../screen/academic/my_home_academic_screen.dart';

class AboutTapbarNavigation extends StatefulWidget {
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
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicator: null,
            isScrollable: false,
            padding: EdgeInsets.zero,
            // indicator: BoxDecoration(),
            tabs: const [
              Tab(text: 'About ISTAD'),
              Tab(text: 'My Director'),
              Tab(text: 'Our Team'),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                HomeIstadScreen(),
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



