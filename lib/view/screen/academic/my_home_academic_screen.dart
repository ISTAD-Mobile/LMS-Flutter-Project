import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/academic/pre_university_screen.dart';

import '../homeScreen/course/course_screen.dart';
import 'IT_expert_screen.dart';
import 'associate_screen.dart';
import 'bachelor_screen.dart';
import 'foundation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyAcademicScreen(),
    );
  }
}

class MyAcademicScreen extends StatelessWidget {
  const MyAcademicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> carouselImages = [
      'assets/images/IT_expert_gen1.png',
      'assets/images/Foundation.jpg',
      'assets/images/IT_expert_gen2.png',
      'assets/images/pre-university.png',
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Fullscreen Carousel Slider
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CarouselSlider(
                items: carouselImages
                    .map(
                      (imagePath) => ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Text Below Carousel
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ប្រភេទវគ្គសិក្សានិងអាហារូបករណ៍",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF253B95),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Category Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3 / 2,
                children: [
                  _HoverCard(
                    title: "Bachelor",
                    imagePath: "assets/images/graduate-avatar.png",
                    page: const BachelorPage(),
                    // currentIndex: 1,
                    // onTabTapped: (int index) {
                    //   // Handle tab change
                    // },
                  ),
                  _HoverCard(
                    title: "Associate",
                    imagePath: 'assets/images/cap.png',
                    page: AssociatePage(),
                    // currentIndex: 1, // Set the appropriate index for the navigation bar
                    // onTabTapped: (int index) {
                    //   // Handle tab change
                    // },
                  ),
                  _HoverCard(
                    title: "Short Course",
                    imagePath: 'assets/images/reading.png',
                    page: const ShortCoursePage(),
                    // currentIndex: 1, // Set the appropriate index for the navigation bar
                    // onTabTapped: (int index) {
                    //   // Handle tab change
                    // },
                  ),
                  _HoverCard(
                    title: "IT Expert",
                    imagePath: 'assets/images/expert-graduate.png',
                    page: const ITExpertPage(),

                  ),
                  _HoverCard(
                    title: "Foundation",
                    imagePath: 'assets/images/graduation.png',
                    page: const FoundationPage(),
                    // currentIndex: 1, // Set the appropriate index for the navigation bar
                    // onTabTapped: (int index) {
                    //   // Handle tab change
                    // },
                  ),
                  _HoverCard(
                    title: "Pre-University",
                    imagePath: 'assets/images/scroll.png',
                    page: const PreUniversityPage(),
                    // currentIndex: 1, // Set the appropriate index for the navigation bar
                    // onTabTapped: (int index) {
                    //   // Handle tab change
                    // },
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

class _HoverCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final Widget page;
  // final int currentIndex;
  // final ValueChanged<int> onTabTapped;

  const _HoverCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.page,
    // required this.currentIndex,
    // required this.onTabTapped,
  }) : super(key: key);

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: _isHovered ? const Color(0xFF253B95) : Colors.transparent,
          width: 2,
        ),
      ),
      elevation: 0,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.page),
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.imagePath,
                height: 40,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 40,
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Color(0xFF253B95),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
