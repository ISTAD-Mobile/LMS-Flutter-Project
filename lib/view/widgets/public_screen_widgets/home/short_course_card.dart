import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

class ShortCourseCard extends StatelessWidget {
  const ShortCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.defaultWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.5,
            color: Colors.grey.shade400,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter mobile development'.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                // Sub title
                const Text(
                  'Flutter course is designed to develop multi-platform like iOS and Android App, Web, Desktop apps like MacOS, Windows and Linux using one code base. We also include with UI / UX design concept. Moreover, integrate with third-party libraries and other mobile functionality to make your app more professional.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.defaultGrayColor,
                  ),
                ),
                // Scholarship discount
                const SizedBox(
                  height: 6,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    '20% Scholarships',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.defaultWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          // Time and level
          Column(
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
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '80 Hours',
                    style: TextStyle(
                      color: AppColors.defaultGrayColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/128/660/660376.png',
                    width: 16,
                    height: 16,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text(
                    'Medium',
                    style: TextStyle(
                      color: AppColors.defaultGrayColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
