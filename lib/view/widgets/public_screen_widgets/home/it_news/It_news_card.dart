import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/model/jobvacancy.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/it_news/it_news_detail.dart';

class ItNewsCard extends StatelessWidget {
  final JobvacancyDataList jobvacancy;
  ItNewsCard(this.jobvacancy);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MMM-yyyy').format(jobvacancy.publishedAt);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItNewsDetail(id: jobvacancy.id),
          ),
        );
      },
      child: Container(
        width: 310,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.5,
            color: Colors.grey.shade400,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                '${jobvacancy.thumbnail}',
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Row(
                    children: [
                      // SVG Icon
                      SvgPicture.string(
                      '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M11.172 2a3 3 0 0 1 2.121.879l7.71 7.71a3.41 3.41 0 0 1 0 4.822l-5.592 5.592a3.41 3.41 0 0 1-4.822 0l-7.71-7.71A3 3 0 0 1 2 11.172V6a4 4 0 0 1 4-4zM7.5 5.5a2 2 0 0 0-1.995 1.85L5.5 7.5a2 2 0 1 0 2-2"/></svg>''',
                      width: 20,
                      height: 20,
                        color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 5),
                    // Text Widget
                    Text(
                      jobvacancy.contentType!.type.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.defaultGrayColor,
                      ),
                    ),
                    ],
                  ),

                  Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.defaultGrayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    jobvacancy.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
