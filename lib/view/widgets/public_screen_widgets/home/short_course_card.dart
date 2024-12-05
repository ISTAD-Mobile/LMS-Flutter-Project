import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

// Model to represent a Course
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

// Sample Course List
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
    title: 'React Native Basics',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
    duration: '60 Hours',
    level: 'Beginner',
    scholarship: '10% Scholarship',
  ),
];

class HorizontalCourseList extends StatelessWidget {
  const HorizontalCourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // Height for the horizontal scroll area
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
    return Container(
      width: 310,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.only(right: 16), // Space between cards
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
          Image.network(
            course.imageUrl,
            width: 85,
            height: 85,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                // Text(
                //   course.description,
                //   maxLines: 2,
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: AppColors.defaultGrayColor,
                //   ),
                // ),
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
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 2),
                    Row(
                      children: [
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/128/660/660376.png',
                          width: 16,
                          height: 16,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          course.level,
                          style: TextStyle(
                            color: AppColors.defaultGrayColor,
                            fontSize: 14,
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
                  child: Text(
                    course.scholarship,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.defaultWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Time and Level
        ],
      ),
    );
  }
}
