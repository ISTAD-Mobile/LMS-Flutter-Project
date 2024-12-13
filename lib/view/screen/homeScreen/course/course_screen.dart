import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/screen/homeScreen/course/course_details_screen.dart';

class CoursePage {
  final String title;
  final String description;
  final String imageUrl;
  final String duration;
  final String level;
  final String scholarship;

  CoursePage({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.level,
    required this.scholarship,
  });


}

final List<CoursePage> coursesPage = [
  CoursePage(
    title: 'Flutter Mobile Development',
    description: 'Develop multi-platform apps using Flutter.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '80 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  CoursePage(
    title: 'IOS DEVELOPMENT',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  CoursePage(
    title: 'SQL & DATA MODELING WITH...',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  CoursePage(
    title: 'Web Design',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  CoursePage(
    title: 'DevOps Engineering',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  CoursePage(
    title: 'C++ Programming',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  CoursePage(
    title: 'Docker',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  CoursePage(
    title: 'Data Analytics',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),

];

class CourseCard extends StatelessWidget {
  final CoursePage coursePage;

  const CourseCard({Key? key, required this.coursePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsPage(),
          ),
        );
      },
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: Colors.grey.shade400),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.network(
                  coursePage.imageUrl,
                  width: 85,
                  height: 85,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: coursePage.title.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: [
                          const TextSpan(
                            text: '\n ',
                            style: TextStyle(
                              color: Colors.transparent,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      coursePage.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.defaultGrayColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/128/3240/3240587.png',
                              width: 16,
                              height: 16,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              coursePage.duration,
                              style: TextStyle(
                                color: AppColors.defaultGrayColor,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/256/17009/17009106.png',
                              width: 16,
                              height: 16,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              coursePage.level,
                              style: TextStyle(
                                color: AppColors.defaultGrayColor,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          coursePage.scholarship,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.defaultWhiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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



class CourseVerticalListPage extends StatelessWidget {
  const CourseVerticalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Back", style: TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'AVAILABLE COURSES',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,color: AppColors.primaryColor),
            ),
            const SizedBox(height: 16),
            ...coursesPage.map(
                  (coursesPage) => Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: CourseCard(coursePage: coursesPage),
              ),
            ).toList(),
          ],
        ),
      ),

    );
  }
}





