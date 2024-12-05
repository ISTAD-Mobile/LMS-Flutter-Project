import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data/color/color_screen.dart';

class AcademicTypeAndScholarshipWidget extends StatelessWidget {
  const AcademicTypeAndScholarshipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'image': 'https://cdn-icons-png.flaticon.com/128/7941/7941552.png',
        'text': 'Bachelor',
        'width': 50.0,
        'height': 50.0,
        'spacing': 12.0,
      },
      {
        'image': 'https://cdn-icons-png.flaticon.com/128/10748/10748520.png',
        'text': 'Associate',
        'width': 55.0,
        'height': 55.0,
        'spacing': 6.0,
      },
      {
        'image': 'https://cdn-icons-png.flaticon.com/128/613/613307.png',
        'text': 'Short Course',
        'width': 45.0,
        'height': 45.0,
        'spacing': 14.0,
      },
      {
        'image': 'https://cdn-icons-png.flaticon.com/128/8262/8262226.png',
        'text': 'IT Expert',
        'width': 55.0,
        'height': 55.0,
        'spacing': 2.0,
      },
      {
        'image': 'https://cdn-icons-png.flaticon.com/128/12005/12005037.png',
        'text': 'Foundation',
        'width': 55.0,
        'height': 55.0,
        'spacing': 0.0,
      },
      {
        'image': 'https://cdn-icons-png.flaticon.com/128/7655/7655706.png',
        'text': 'Pre-University',
        'width': 45.0,
        'height': 45.0,
        'spacing': 18.0,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ប្រភេទវគ្គសិក្សា និង អាហារូបករណ៍',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansKhmer',
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: List.generate(items.length, (index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 25,
                height: 150,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.defaultWhiteColor,
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,
                          BlendMode.srcIn,
                        ),
                        child: Image.network(
                          items[index]['image'],
                          width: items[index]['width'],
                          height: items[index]['height'],
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const CircularProgressIndicator();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: items[index]['spacing']),
                      Text(
                        items[index]['text'],
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
