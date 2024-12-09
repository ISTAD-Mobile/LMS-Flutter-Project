import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';


class TestimonialPage extends StatefulWidget {
  const TestimonialPage({Key? key}) : super(key: key);

  @override
  _TestimonialPageState createState() => _TestimonialPageState();
}

class _TestimonialPageState extends State<TestimonialPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> testimonials = [
    {
      "name": "Mr. PHON SOBON",
      "role": "Student from ISTAD",
      "image": "assets/images/Testimonial Profile (4).png",
      "quote": "At CSTAD, I'm learning a lot about IT. The teachers are really good and help me understand things easily..."
    },
    {
      "name": "Mrs. SIN MANNY",
      "role": "Student from ISTAD",
      "image": "assets/images/Testimonial Profile (5).png",
      "quote": "As a student at CSTAD, I confidently say here is the best place for students who would like ....",
    },
    {
      "name": "Mr. PHIV LYHOU",
      "role": "Student from ISTAD",
      "image": "assets/images/Testimonial Profile (6).png",
      "quote": "CSTAD is the best for who want to improve your IT skill I'm highly recommend ",
    },
    {
      "name": "Mrs. SEA MEY",
      "role": "Student from ISTAD",
      "image": "assets/images/Testimonial Profile (7).png",
      "quote": "CSTAD is the best for place for thoes who want to learn IT. Good environment with the best mentor... ",
    },
    {
      "name": "Mrs. Ni taa",
      "role": "Student from ISTAD",
      "image": "assets/images/Testimonial Profile (8).png",
      "quote": "Reflecting on my unforgettable journey at the  Center of Science and Technology Advanced Development ... ",
    },
    {
      "name": "Mrs. VOTEY",
      "role": "Student from ISTAD",
      "image": "assets/images/Testimonial Profile (9).png",
      "quote": "A good environment school with the best mentors and learning system. ",
    },
    {
      "name": "Mrs. HElEN LEANG ",
      "role": "Student from ISTAD",
      "image": "assets/images/Testimonial Profile (10).png",
      "quote": "Don’t know where to start with your IT path? I highly recommend CSTAD as there will be many ... ",
    },
    {
      "name": "Mrs. PANHA ",
      "role": "Student from ISTAD",
      "image": "assets/images/Testimonial Profile (11).png",
      "quote": "I strongly recommend CSTAD to all my IT fellows who want to effectively gain a skill in a short time ... ",
    },
    {
      "name": "Mr. CHEA CHENTO ",
      "role": "Student from ISTAD",
      "image": "assets/images/Testimonial Profile (12).png",
      "quote": "At CSTAD, I'm learning a lot about IT. The teachers are really good and help me understand things easily ... ",
    },
    {
      "name": "Mr. SONG ",
      "role": "Student from ISTAD",
      "image": "assets/images/Testimonial Profile (13).png",
      "quote": "Highly recommend for everyone who want to develop our skill in a short time and want to choose the right way as a good programmer... ",
    },
  ];

  @override
  void initState() {
    super.initState();
    autoScroll();
  }

  void autoScroll() {
    Future.delayed(const Duration(seconds: 5), () {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % testimonials.length;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        autoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 16,left: 16,bottom: 16),
            child: const Text(
              'HEAR FROM OUR STUDENT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                final testimonial = testimonials[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Transform.scale(
                    scale: index == _currentPage ? 1.0 : 0.95,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                          color: Color(0x1A535763),
                          width: 1,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(testimonial['image']!),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              testimonial['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              testimonial['role']!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              testimonial['quote']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              testimonials.length,
                  (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: const EdgeInsets.all(4),
                width: _currentPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? AppColors.primaryColor : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }
}
