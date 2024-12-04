import 'package:flutter/cupertino.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/short_course_card.dart';

import '../../../../data/color/color_screen.dart';

class CourseSection extends StatelessWidget {
  const CourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and "See More" Text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Short Course'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const Text(
                'see more',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Horizontal scrolling list of ShortCourseCard
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ShortCourseCard(),
                ShortCourseCard(),
                ShortCourseCard(),
                ShortCourseCard(),
                ShortCourseCard(),
                ShortCourseCard(),
                ShortCourseCard(),
                ShortCourseCard(),
                ShortCourseCard(),
                ShortCourseCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
