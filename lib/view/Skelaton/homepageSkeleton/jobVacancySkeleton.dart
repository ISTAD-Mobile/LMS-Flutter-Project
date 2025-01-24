import 'package:flutter/material.dart';

class Jobvacancyskeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 20),
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
          // Skeleton for Image Section (Simple placeholder)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.grey.shade300,  // Placeholder color for image
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skeleton for Date and Category Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSkeletonBox(60, 12),
                    _buildSkeletonBox(60, 12),
                  ],
                ),
                const SizedBox(height: 16),
                // Skeleton for Title Section
                _buildSkeletonBox(180, 20),
                const SizedBox(height: 6),
                // Skeleton for Description Section
                _buildSkeletonBox(250, 15),
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
