import 'package:flutter/material.dart';

class Jobvacancyskeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      margin: const EdgeInsets.only(bottom: 20,right: 15),
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
            child: Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey.shade300, // Placeholder color for image
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
                      // Skeleton for contentType Text
                      _buildSkeletonBox(80, 12),
                      // Skeleton for formattedDate Text
                      _buildSkeletonBox(60, 12),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Skeleton for title Text
                _buildSkeletonBox(180, 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create rectangular skeleton boxes
  Widget _buildSkeletonBox(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade300, // Placeholder color
    );
  }
}
