import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Coursscreenskeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Expanded(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.defaultWhiteColor,
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
              Container(
                width: 85,
                height: 85,
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
                    Container(
                      width: double.infinity,
                      height: 20,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      height: 14,
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      width: double.infinity,
                      height: 14,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 6),
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
