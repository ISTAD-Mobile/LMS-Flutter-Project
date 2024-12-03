import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

class ShortCourseCard extends StatelessWidget {
  final double width;  // Adding width parameter to control card width

  const ShortCourseCard({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Set width of the card
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.defaultWhiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.5,
          color: Colors.grey.shade400,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Center(
            child: Image.network(
              'https://api.istad.co/media/image/899bac49-e47c-406c-abb2-30ad0b498f88.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          // Course details
          Text(
            'Flutter mobile development'.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Flutter course is designed to develop multi-platform like iOS and Android App, Web, Desktop apps like MacOS, Windows and Linux using one code base. We also include with UI / UX design concept. Moreover, integrate with third-party libraries and other mobile functionality to make your app more professional.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.defaultGrayColor,
            ),
          ),
          const SizedBox(height: 6),
          // Scholarship label
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
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
          ),
          const SizedBox(height: 10),
          // Time and level info
          Row(
            children: [
              Image.network(
                'https://cdn-icons-png.flaticon.com/128/3240/3240587.png',
                width: 16,
                height: 16,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 8),
              const Text(
                '80 Hours',
                style: TextStyle(
                  color: AppColors.defaultGrayColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Image.network(
                'https://cdn-icons-png.flaticon.com/128/660/660376.png',
                width: 16,
                height: 16,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 6),
              const Text(
                'Medium',
                style: TextStyle(
                  color: AppColors.defaultGrayColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
