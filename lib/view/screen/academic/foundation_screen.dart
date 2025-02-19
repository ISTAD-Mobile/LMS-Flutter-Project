import 'package:flutter/material.dart';
import '../../../data/color/color_screen.dart';

class FoundationPage extends StatefulWidget {
  const FoundationPage({super.key});

  @override
  _ITExpertPageState createState() => _ITExpertPageState();
}

class _ITExpertPageState extends State<FoundationPage> {
  int currentIndex = 0;

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
        title: const Text(
          "Foundation",
          style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/Foundation.jpg',
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
              // const SizedBox(height: 2),
              const Text(
                "Foundation Scholarship",
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
              const Row(
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
                    "8:00 am - 12:00 pm",
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
                    padding: EdgeInsets.only(right: 36.0),
                    // Add right padding to "8hr"
                    child: Text(
                      "4hr",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Row(
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
                    "1:00 pm - 5:00 pm",
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
                    padding: EdgeInsets.only(right: 36.0),
                    // Add right padding to "8hr"
                    child: Text(
                      "4hr",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Foundation Courses
              const Text(
                "Foundation Courses",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF253B95),
                ),
              ),
              const SizedBox(height: 15),
              _buildCourseList([
                "Java Programming",
                "Web Design",
                "Bootstrap & Tailwind",
                "ReactJS",
                "Database",
                "Spring",
                "Git and Deployment",
                "UX/UI Concept and Design",
                "Project Management",
              ]),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseList(List<String> courses) {
    return Column(
      children: courses
          .map(
            (course) => Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
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
          ).toList(),
    );
  }
}
