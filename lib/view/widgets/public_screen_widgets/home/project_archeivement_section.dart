import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/project_archeivement_gen1.dart';

import '../../../screen/homeScreen/project_achievement/project_achievement_screen.dart';

class ProjectArcheivementHome extends StatelessWidget {
   ProjectArcheivementHome({Key? key}) : super(key: key);

  final List<ProjectGenerationOne> generations = [
    ProjectGenerationOne(
      projects: [
        Project(
            title: 'Live Hacking Demo',
            description: 'A tool to do the pentesting purpose on a website such...',
            image: Image.asset('assets/images/project_live-demo.png',width: 60,height: 60,),
            iconBgColor: Colors.blue,
            label: '1st | Advanced',
            features: [
              'SQL Injection, XSS',
              'Vulnerabilities Scanning',
              'Generating Reports',
            ],
            textIcon: '',
            textWithIcon: 'Cybersecurity'
        ),
        Project(
            title: 'K-QuickSight',
            description: 'Catalyze your data journey with our powerful tools for...',
            image: Image.asset('assets/images/project_k-quicksignt.jpg',width: 60,height: 60,),
            iconBgColor: Colors.green,
            label: '1st | Advanced',
            features: [
              'Data Prep Made Easy',
              'Intelligent Insights',
              'User-Friendly Dashboards',
            ],
            textIcon: '',
            textWithIcon: 'Data Analytics'
        ),
        Project(
          title: 'DealKh',
          description: 'Dive deep into the world of ecommerce with this...',
          image: Image.asset('assets/images/project_dealKH.png',width: 60,height: 60,),
          iconBgColor: Colors.blue,
          label: '2nd | Basic',
          features: [
            'Learn from Experts',
            'Grow Your Business',
            'Connect with Others',
          ],
          textIcon: '',
          textWithIcon: 'E-Commerce Global',
        ),
        Project(
          title: 'ALUMINI',
          description: 'This space is dedicated to fostering a vibrant...',
          image: Image.asset('assets/images/project_alumni.png',width: 60,height: 60,),
          iconBgColor: Colors.green,
          label: '2nd | Basic',
          features: [
            'Social Activities',
            'Sharing Community',
            'Tutorials',
          ],
          textIcon: '',
          textWithIcon: 'Social & Community',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PROJECT ARCHIVEMENT'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectListScreenHome(),
                    ),
                  );
                },
                child: const Text(
                  'See More',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: generations[0].projects.map((project) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SizedBox(
                    width: 300,
                    child: ProjectCard(project: project),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
