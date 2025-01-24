import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

class CourseScreenSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.defaultWhiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Skeleton for thumbnail
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Container(
                  height: 14,
                  width: 200,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    for (int i = 0; i < 3; i++) ...[
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 5),
                          Container(
                            height: 14,
                            width: 30,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: 120,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
