import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/about/my_home_about_istad_screen.dart';
import '../../../data/color/color_screen.dart';
import '../../home.dart';
import '../lms/auth/first_log_in_screen.dart';
import 'my_home_academic_screen.dart';

class PreUniversityPage extends StatefulWidget {
  const PreUniversityPage({Key? key}) : super(key: key);

  @override
  _PreUniversityPageState createState() => _PreUniversityPageState();
}

class _PreUniversityPageState extends State<PreUniversityPage> {
  int currentIndex = 0;

  // List of screens for each tab
  final List<Widget> screens = [
     HomeScreen(),
    const MyAcademicScreen(),
    const HomeIstadScreen(),
    const firstSignInScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text("Pre-University",style: TextStyle(fontSize: 16,color: AppColors.primaryColor),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/pre-university.png', // Replace with the correct image
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Closed",
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Text(
                "Pre-University Scholarship",
                style: TextStyle(
                  color: Color(0xFF253B95),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Institute of Science and Technology Advanced Development currently provides a 100% scholarship opportunity for 60 places in 2024.",
                style: TextStyle(
                  color: Color(0xFF535763),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),

              // Web Design Section
              const Text(
                "Web Design",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF253B95),
                ),
              ),
              const SizedBox(height: 15),
              _buildCourseList([
                "Introduction",
                "HTML - HyperText Markup Language",
                "CSS - Cascading Style Sheets",
                "Bootstrap & Tailwind",
                "Git and Deployment",
                "UX/UI Concept and Design",
                "JavaScript",
              ]),
              const SizedBox(height: 16),

              // First Time and Hour Section
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text(
                    "Morning: ",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "10:00 am - 12:30 pm",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                   Spacer(),
                   Text(
                    "Hours: ",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      "2hr",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text(
                "C++ Programming",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF253B95),
                ),
              ),
              SizedBox(height: 15),
              _buildCourseList([
                "Introduction",
                "Basic Syntax",
                "Control Flow Statement",
                "Array in C++",
                "Object-Oriented Programming",
                "Database",
              ]),
              const SizedBox(height: 16),

              // Second Time and Hour Section (Below C++ Programming)
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Afternoon: ",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "3:00 pm - 5:00 pm", // Updated time for this section
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                 Spacer(),
                 Text(
                    "Hours: ",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      "2hr", // Updated hours for this section
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build the course list with star icon and padding adjustments
  Widget _buildCourseList(List<String> courses) {
    return Column(
      children: courses
          .map(
            (course) => Padding(
          padding: const EdgeInsets.only(left: 10.0,bottom: 10.0),
          child: Row(
            children: [
              const Icon(
                Icons.star,
                color: Color(0xFFEAB305),
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                course,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF535763),
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}
