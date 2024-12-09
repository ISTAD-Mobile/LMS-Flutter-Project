import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/screen/homeScreen/course/course_details_screen.dart';

class Course {
  final String title;
  final String description;
  final String imageUrl;
  final String duration;
  final String level;
  final String scholarship;

  Course({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.level,
    required this.scholarship,
  });
}

final List<Course> courses = [
  Course(
    title: 'Flutter Mobile Development',
    description: 'Develop multi-platform apps using Flutter.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '80 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  Course(
    title: 'IOS DEVELOPMENT',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  Course(
    title: 'SQL & DATA MODELING WITH...',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  Course(
    title: 'Web Design',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  Course(
    title: 'DevOps Engineering',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  Course(
    title: 'C++ Programming',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  Course(
    title: 'Docker',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
  Course(
    title: 'Data Analytics',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
  ),
];

class HorizontalCourseList extends StatelessWidget {
  const HorizontalCourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return ShortCourseCard(course: course);
        },
      ),
    );
  }
}

class ShortCourseCard extends StatelessWidget {
  final Course course;

  const ShortCourseCard({Key? key, required this.course}) : super(key: key);

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
        width: 325,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.defaultWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.5,
            color: Colors.grey.shade400,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                course.imageUrl,
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
                      text: course.title.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
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
                    course.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.defaultGrayColor,
                    ),
                  ),
                  const SizedBox(height: 6),
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
                            course.duration,
                            style: TextStyle(
                              color: AppColors.defaultGrayColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
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
                            course.level,
                            style: TextStyle(
                              color: AppColors.defaultGrayColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        course.scholarship,
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
            // Time and Level
          ],
        ),
      ),
    );
  }
}
