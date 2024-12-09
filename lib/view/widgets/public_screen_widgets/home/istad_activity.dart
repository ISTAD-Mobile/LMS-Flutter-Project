import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

class IstadActivity extends StatelessWidget {
  const IstadActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              SizedBox(
                width: 6,
                height:55,
                child: Container(
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Istad\nActivity'.toUpperCase(),
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // sub title
          const Text(
            'School Activities',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          const Text(
            'Showcase activity at ISTAD like admission interview, entrance exam,special lectures, monthly party, study activity, review, exam, short course, pre-university, foundation, and expert course.',
            // textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildImageContainer(context, 160, 0),
                      _buildImageContainer(context, 220, 2),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildImageContainer(context, 220, 1),
                      _buildImageContainer(context, 160, 3),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Image.network(
              'https://www.cstad.edu.kh/_next/image?url=https%3A%2F%2Flms-api.istad.co%2Fapi%2Fv1%2Fmedias%2Fview%2F5992e761-c2a9-45ab-bedd-e5ddb5fe6645.png&w=3840&q=75'),
        ],
      ),
    );
  }

  Widget _buildImageContainer(BuildContext context, double height, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      height: height,
      width: (MediaQuery.of(context).size.width / 2) - 22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(_imageUrls[index]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

const List<String> _imageUrls = [
  'https://www.cstad.edu.kh/_next/image?url=https%3A%2F%2Flms-api.istad.co%2Fapi%2Fv1%2Fmedias%2Fview%2F378d40e6-cbc3-4186-9521-c620ccb1aed7.jpg&w=750&q=75',
  'https://www.cstad.edu.kh/_next/image?url=https%3A%2F%2Flms-api.istad.co%2Fapi%2Fv1%2Fmedias%2Fview%2F9118f9a1-994e-48cb-8070-7d5354b0f243.png&w=750&q=75',
  'https://www.cstad.edu.kh/_next/image?url=https%3A%2F%2Flms-api.istad.co%2Fapi%2Fv1%2Fmedias%2Fview%2Fc946e2b9-84d8-434d-a87c-57f0e12656b8.png&w=750&q=75',
  'https://www.cstad.edu.kh/_next/image?url=https%3A%2F%2Flms-api.istad.co%2Fapi%2Fv1%2Fmedias%2Fview%2F672899f7-b724-46ac-993e-d207208d3177.png&w=750&q=75',
];
