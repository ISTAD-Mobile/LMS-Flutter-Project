import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/screen/academic/pre_university_screen.dart';
import '../homeScreen/course/course_screen.dart';
import 'IT_expert_screen.dart';
import 'associate_screen.dart';
import 'bachelor_screen.dart';
import 'foundation_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAcademicScreen(),
    );
  }
}

class MyAcademicScreen extends StatelessWidget {
  const MyAcademicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> carouselImages = [
      'https://dev-flutter.cstad.edu.kh/api/v1/medias/view/ca4912cd-a733-4f4e-badd-e7756895647e.png',//IT expert gen 1
      'https://dev-flutter.cstad.edu.kh/api/v1/medias/view/9d783fa5-e8ff-4666-a054-a5fc45367729.jpg',//foundation
      'https://dev-flutter.cstad.edu.kh/api/v1/medias/view/f0d8b9fb-bf7f-4448-ab96-1e9fd6634be6.jpg',//IT expert gen 2
      'https://dev-flutter.cstad.edu.kh/api/v1/medias/view/404852a2-f6d5-4ded-9d93-2c6ec53ccdfe.jpg',//Pre_university
    ];

    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CarouselSlider(
                items: carouselImages
                    .map(
                      (imagePath) => ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Image.network(
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
                    ).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ប្រភេទវគ្គសិក្សានិងអាហារូបករណ៍",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF253B95),
                    fontFamily: 'NotoSansKhmer',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.8,
                children: [
                  const _HoverCard(
                    title: "Bachelor",
                    imagePath:
                        "https://cdn-icons-png.flaticon.com/128/7941/7941552.png",
                    page: BachelorPage(),
                  ),
                  _HoverCard(
                    title: "Associate",
                    imagePath:
                        'https://cdn-icons-png.flaticon.com/128/10748/10748520.png',
                    page: AssociatePage(),
                  ),
                  _HoverCard(
                    title: "Short Course",
                    imagePath:
                        'https://cdn-icons-png.flaticon.com/128/613/613307.png',
                    page: ShortCoursePage(),
                  ),
                  const _HoverCard(
                    title: "IT Expert",
                    imagePath:
                        'https://cdn-icons-png.flaticon.com/128/8262/8262226.png',
                    page: ITExpertPage(),
                  ),
                  const _HoverCard(
                    title: "Foundation",
                    imagePath:
                        'https://cdn-icons-png.flaticon.com/128/12005/12005037.png',
                    page: FoundationPage(),
                  ),
                  const _HoverCard(
                    title: "Pre-University",
                    imagePath:
                        'https://cdn-icons-png.flaticon.com/128/7655/7655706.png',
                    page: PreUniversityPage(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
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

  const _HoverCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.page,
  }) : super(key: key);

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: _isHovered ? const Color(0xFF253B95) : Colors.grey[300]!,
          width: 1,
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
          child: Container(
            height: 500,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  color: AppColors.primaryColor,
                  widget.imagePath,
                  height: 35,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
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
      ),
    );
  }
}
