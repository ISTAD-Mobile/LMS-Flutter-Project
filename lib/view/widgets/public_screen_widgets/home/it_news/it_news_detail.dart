import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

class ItNewsDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.defaultGrayColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Title',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 2),
            // Main Image
            ClipRRect(
              child: Image.network(
                'thumbnail',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Date and Category Row
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,
                        size: 16,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                       'publishedAt',
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                    Row(
                      children: [
                        const Icon(Icons.folder,
                          size: 16,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: Text(
                            'contentType.type',
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'editorContent',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}






// Text(
//   news.description,
//   style: const TextStyle(
//     fontSize: 16,
//     color: AppColors.defaultGrayColor,
//     height: 1.5,
//   ),
// ),
// const SizedBox(height:30),
// // Course Details
// Container(
//   padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(8),
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       ClipRRect(
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(8),
//           bottom: Radius.circular(8),
//         ),
//         child: Image.network(
//           news.imageUrl1,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         ),
//       ),
//       const SizedBox(height: 25,),
//       ClipRRect(
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(8),
//           bottom: Radius.circular(8),
//         ),
//         child: Image.network(
//           news.imageUrl2,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         ),
//       ),
//       const SizedBox(height: 30,),
//       Text(
//         news.title,
//         style: const TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w500,
//           color: AppColors.primaryColor,
//         ),
//       ),
//       Text(
//         news.description,
//         style: const TextStyle(
//           fontSize: 16,
//           color: AppColors.defaultGrayColor,
//           height: 1.5,
//         ),
//       ),
//       const SizedBox(height: 20,),
//       ClipRRect(
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(8),
//           bottom: Radius.circular(8),
//         ),
//         child: Image.network(
//           news.imageUrl3,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         ),
//       ),
//       const SizedBox(height: 25,)
//     ],
//   ),
// ),