import 'package:flutter/material.dart';
import 'package:lms_mobile/view/home.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/project_archeivement_gen1.dart';

import '../../../../data/color/color_screen.dart';
import '../../../widgets/public_screen_widgets/home/project_archeivement_gen2.dart';

void main() {
  runApp(ProjectListScreenHome());
}

class ProjectListScreenHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProjectListScreen(),
    );
  }
}

class ProjectListScreen extends StatelessWidget {
  // Sample data
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
          textWithIcon: 'Cybersecurity',
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
            title: 'AutomateX',
            description: 'DevOps platform for deploying database and...',
            image: Image.asset('assets/images/project_automiclogo.png',width: 60,height: 60,),
            iconBgColor: Colors.green,
            label: '1st | Advanced',
            features: [
              'Deploy Database',
              'Deploy Software',
              'Deploy Domain Name',
            ],
            textIcon: '',
            textWithIcon: 'DevOps'
        ),
        Project(
            title: 'iSTADemy',
            description: 'Unlock your coding potential at iSTADemy Learn...',
            image: Image.asset('assets/images/project_istaddemy.png',width: 60,height: 60,),
            iconBgColor: Colors.green,
            label: '1st | Basic',
            features: [
              'Code Playground',
              'Exercises and Quizzes',
              'Earn Certificate',
            ],
            textIcon: '',
            textWithIcon: 'Education'
        ),
        Project(
            title: 'PhotoSTAD',
            description: 'Brand your pictures with the free watermark and...',
            image: Image.asset('assets/images/project_photoStad.png',width: 60,height: 60,),
            iconBgColor: Colors.green,
            label: '1st | Basic',
            features: [
              'Watermarking picture',
              'Generate Certification',
              'Tutorials',
            ],
            textIcon: '',
            textWithIcon: 'Design'
        ),
        Project(
            title: 'SurveyBox',
            description: 'It offers a variety of features, including a wide range of...',
            image: Image.asset('assets/images/project_surveybox.png',width: 60,height: 60,),
            iconBgColor: Colors.green,
            label: '1st | Basic',
            features: [
              'Voting Form',
              'Suggested Q&A',
              'Report of Survey',
            ],
            textIcon: '',
            textWithIcon: 'Productivity'
        ),
        Project(
            title: 'CamGiving',
            description: 'Donority is here to build a safe future for the next...',
            image: Image.asset('assets/images/project_camgiving.jpg',width: 60,height: 60,),
            iconBgColor: Colors.green,
            label: '1st | Basic',
            features: [
              'Donation System',
              'Social Activities',
              'Organization',
            ],
            textIcon: '',
            textWithIcon: 'Social & Donation'
        ),
        Project(
            title: 'Brachhna',
            description: 'Brachhna is a website created to educate students...',
            image: Image.asset('assets/images/project_brachhna.png',width: 60,height: 60,),
            iconBgColor: Colors.green,
            label: '1st | Basic',
            features: [
              'Education Games',
              'Khmer, English, Math',
              'Kid Resources',
            ],
            textIcon: '',
            textWithIcon: 'Productivity'
        ),
        Project(
            title: 'Developers Cambodia',
            description: 'Developers community for Cambodian that developers...',
            image: Image.asset('assets/images/project_developer_cambodia.png',width: 60,height: 60,),
            features: ['E-Learning', 'Global Forum', 'Sharing Community'],
            iconBgColor: Colors.blue,
            label: '1st | Advanced',
            textIcon: '',
            textWithIcon: 'Khmer Community'
        ),
      ],
    ),
  ];

  final List<ProjectGenerationTwo> projectGenerations = [
    ProjectGenerationTwo(
      projectGenTwo: [
        ProjectGenTwo(
          title: 'iFinder',
          description: 'There are many general web search engines that are...',
          image: Image.asset('assets/images/project_ifinder.png',width: 60,height: 60,),
          features: ['Web Search Engines', 'File Search Tools', 'Quickly search'],
          iconBgColor: Colors.blue,
          label: '2nd | Basic',
          textIcon: '',
          textWithIcon: 'Khmer Community',
        ),
        ProjectGenTwo(
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
        ProjectGenTwo(
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
        ProjectGenTwo(
          title: 'iDATA',
          description: 'There are many resources available online to help you...',
          image: Image.asset('assets/images/project_idata.png',width: 60,height: 60,),
          iconBgColor: Colors.green,
          label: '2nd | Basic',
          features: [
            'Public API directories',
            'RapidAPI',
            'Terms of service',
          ],
          textIcon: '',
          textWithIcon: 'API Integration',
        ),
        ProjectGenTwo(
          title: 'GradesBot',
          description: 'Our mission at GradesBot is to innovate education...',
          image: Image.asset('assets/images/project_gradebot.jpg',width: 60,height: 60,),
          iconBgColor: Colors.green,
          label: '2nd | Basic',
          features: [
            'Effortlessly Track Grades',
            'Boost Engagement',
            'Communication',
          ],
          textIcon: '',
          textWithIcon: 'Innovation in Education',
        ),
        ProjectGenTwo(
          title: 'iSTAD LMS',
          description: 'ISTAD Learning Management System is an advanced web...',
          image: Image.asset('assets/images/project_lms_istad.png',width: 60,height: 60,),
          iconBgColor: Colors.green,
          label: '2nd | Basic',
          features: [
            'System Management',
            'Sharing Community',
            'Knowledge',
          ],
          textIcon: '',
          textWithIcon: 'System Management',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          },
          icon: const Icon(Icons.arrow_back,color: AppColors.primaryColor),
        ),
        // title: const Text(
        //   "Back",
        //   style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
        // ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   color: AppColors.backgroundColor,
        // ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PROJECT 1st GENERATION',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
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
              const SizedBox(height: 20),
              const Text(
                'PROJECT 2nd GENERATION',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: projectGenerations[0].projectGenTwo.map((projectGenTwo) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SizedBox(
                        width: 300,
                        child: ProjectCardGenTwo(projectGenTwo: projectGenTwo),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
