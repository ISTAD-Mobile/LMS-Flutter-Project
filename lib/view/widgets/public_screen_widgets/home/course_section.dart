import 'package:flutter/cupertino.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/short_course_card.dart';

class CourseSection extends StatelessWidget {
  const CourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Title
                Text(
                  'Short Course'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor
                  ),
                ),
                // See more
                const Text(
                  'see more',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            ShortCourseCard(),
          ],
        )
      ),
    );
  }
}
