import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';


class ShortCourseCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(  // Use SizedBox to ensure size constraints
        width: MediaQuery.of(context).size.width, // Set width
        height: 150, // Set height
        child: Container(
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
              // Skeleton for the image (using a Container)
              Container(
                width: 85, // Ensure width and height are set here
                height: 85, // Ensure height is set here
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade300,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Skeleton for the title
                    Container(
                      width: double.infinity,
                      height: 20,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 4),
                    // Skeleton for the description
                    Container(
                      width: double.infinity,
                      height: 14,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 6),
                    // Skeleton for the time and level
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 14,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 60,
                          height: 14,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Skeleton for the fee button
                    Container(
                      width: 200,
                      height: 30,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
