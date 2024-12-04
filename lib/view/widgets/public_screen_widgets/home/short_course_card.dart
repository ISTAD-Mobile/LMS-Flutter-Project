import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

class ShortCourseCard extends StatelessWidget {
  const ShortCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
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
            // Image
            Image.network(
              'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),

            // Title and Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Flutter mobile development'.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Flutter course is designed to develop multi-platform like iOS and Android App, Web, Desktop apps like MacOS, Windows, and Linux using one code base. We also include UI/UX design concepts. Moreover, integrate with third-party libraries and other mobile functionality to make your app more professional.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.defaultGrayColor,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      '20% Scholarships',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.defaultWhiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Time and Level
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/128/3240/3240587.png',
                      width: 20,
                      height: 20,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      '80 Hours',
                      style: TextStyle(color: AppColors.defaultGrayColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/128/660/660376.png',
                      width: 20,
                      height: 20,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      'Medium',
                      style: TextStyle(color: AppColors.defaultGrayColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
