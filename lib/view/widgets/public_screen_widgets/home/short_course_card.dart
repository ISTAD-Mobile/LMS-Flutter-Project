import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/model/course.dart';
import 'package:lms_mobile/view/screen/homeScreen/course/course_details_screen.dart';

class ShortCourseCard extends StatelessWidget {
  final Course course;

  ShortCourseCard(this.course);

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
        width: 310,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                course.thumbnailUri,
                width: 60,
                height: 60,
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
                    maxLines: 1,
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
                          SvgPicture.string(
                            '''
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M17 3.34a10 10 0 1 1-14.995 8.984L2 12l.005-.324A10 10 0 0 1 17 3.34M12 6a1 1 0 0 0-.993.883L11 7v5l.009.131a1 1 0 0 0 .197.477l.087.1l3 3l.094.082a1 1 0 0 0 1.226 0l.094-.083l.083-.094a1 1 0 0 0 0-1.226l-.083-.094L13 11.585V7l-.007-.117A1 1 0 0 0 12 6"/></svg>
                              ''',
                            width: 20,
                            height: 20,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 5),
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
                          SvgPicture.string(
                            '''
                              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" fill-rule="evenodd" d="M12.02 3.5c.122 0 .215.108.199.229a21 21 0 0 0 .103 6.225l.014.087a.25.25 0 0 0 .456.095l1.624-2.501a.1.1 0 0 1 .168 0l1.624 2.501a.25.25 0 0 0 .456-.095l.014-.087c.345-2.06.379-4.158.103-6.225a.202.202 0 0 1 .2-.229H18.5A1.5 1.5 0 0 1 20 5v15a1 1 0 0 1-1 1H7.5a3.5 3.5 0 0 1-3.465-3H4V8a4.5 4.5 0 0 1 4.5-4.5zm-4.52 12h11v4h-11a2 2 0 1 1 0-4" clip-rule="evenodd"/></svg>
                              ''',
                            width: 20,
                            height: 20,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            course.totalLesson.toString(),
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
                          SvgPicture.string(
                            '''
                              <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512"><path fill="currentColor" d="M256 256c-13.47 0-26.94-2.39-37.44-7.17l-148-67.49C63.79 178.26 48 169.25 48 152.24s15.79-26 22.58-29.12l149.28-68.07c20.57-9.4 51.61-9.4 72.19 0l149.37 68.07c6.79 3.09 22.58 12.1 22.58 29.12s-15.79 26-22.58 29.11l-148 67.48C282.94 253.61 269.47 256 256 256m176.76-100.86"/><path fill="currentColor" d="M441.36 226.81L426.27 220l-38.77 17.74l-94 43c-10.5 4.8-24 7.19-37.44 7.19s-26.93-2.39-37.42-7.19l-94.07-43L85.79 220l-15.22 6.84C63.79 229.93 48 239 48 256s15.79 26.08 22.56 29.17l148 67.63C229 357.6 242.49 360 256 360s26.94-2.4 37.44-7.19l147.87-67.61c6.81-3.09 22.69-12.11 22.69-29.2s-15.77-26.07-22.64-29.19"/><path fill="currentColor" d="m441.36 330.8l-15.09-6.8l-38.77 17.73l-94 42.95c-10.5 4.78-24 7.18-37.44 7.18s-26.93-2.39-37.42-7.18l-94.07-43L85.79 324l-15.22 6.84C63.79 333.93 48 343 48 360s15.79 26.07 22.56 29.15l148 67.59C229 461.52 242.54 464 256 464s26.88-2.48 37.38-7.27l147.92-67.57c6.82-3.08 22.7-12.1 22.7-29.16s-15.77-26.07-22.64-29.2"/></svg>
                              ''',
                            width: 20,
                            height: 20,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 5),
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
                  SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      child: Text('20% Schoolarship',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.defaultWhiteColor,
                          fontWeight: FontWeight.w500,
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
