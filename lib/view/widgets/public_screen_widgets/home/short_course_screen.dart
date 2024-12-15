import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/model/course.dart';
import 'package:lms_mobile/view/screen/homeScreen/course/course_details_screen.dart';

class ShortCourseScreen extends StatelessWidget {
  final Course course;

  ShortCourseScreen(this.course);

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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.5,
            color: Colors.grey.shade400,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.network(
                course.thumbnailUri,
                width: 70,
                height: 70,
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
                      children: const [
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
                    style: const TextStyle(
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
                            course.totalHour.toString(),
                            style: const TextStyle(
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
                            style: const TextStyle(
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
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        course.fee.toString(),
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
