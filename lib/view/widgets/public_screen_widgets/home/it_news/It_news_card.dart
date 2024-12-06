import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

// News model remains the same
class News {
  final String title;
  final String description;
  final String imageUrl;
  final String duration;
  final String level;
  final String scholarship;
  final String date;
  final String category;
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;

  News({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.level,
    required this.scholarship,
    required this.date,
    required this.category,
    required this.imageUrl1,
    required this.imageUrl2,
    required this.imageUrl3,
  });
}

// Sample news list remains the same
final List<News> news = [
  News(
    title: 'Flutter Mobile Development',
    description: 'Develop multi-platform apps using Flutter.',
    imageUrl: 'https://www.cstad.edu.kh/_next/image?url=https%3A%2F%2Fapi.istad.co%2Fmedia%2Fimage%2F779a9824-0e29-44ff-9f4c-922d78f04b1f.png&w=1920&q=75',
    imageUrl1: 'https://api.istad.co/media/image/fa205db1-ebb5-422c-aed2-a8a0131446dd.png',
    imageUrl2: 'https://api.istad.co/media/image/06ffb981-e3c0-4ade-9aa2-c03675ece205.png',
    imageUrl3: 'https://api.istad.co/media/image/609b4320-405d-47df-a422-a2efec4f8de2.png',
    duration: '80 Hours',
    level: 'Medium',
    scholarship: '20% Scholarship',
    date: '14/12/2023',
    category: 'Blog',
  ),
  News(
    title: 'React Native Basics',
    description: 'Build native apps with React Native.',
    imageUrl: 'https://www.cstad.edu.kh/_next/image?url=https%3A%2F%2Fapi.istad.co%2Fmedia%2Fimage%2F53e118d6-58e3-4ec1-b40c-ef44f09c441e.jpg&w=1920&q=75',
    imageUrl1: 'https://api.istad.co/media/image/4a4f665a-4f80-4552-9447-0e9abd1d8fa8.png',
    imageUrl2: 'https://api.istad.co/media/image/f5ede6f6-f983-4b83-bdee-3d645b81f653.png',
    imageUrl3: 'https://api.istad.co/media/image/5939e4f1-d086-461d-be00-7127052811c8.png',
    duration: '60 Hours',
    level: 'Beginner',
    scholarship: '10% Scholarship',
    date: '14/12/2023',
    category: 'Blog',
  ),
];

class HorizontalNewsList extends StatelessWidget {
  const HorizontalNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // Height for the horizontal scroll area
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: news.length,
        itemBuilder: (context, index) {
          final currentNews = news[index]; // Use a clear variable name
          return ItNewsCard(news: currentNews); // Pass the correct item to the widget
        },
      ),
    );
  }
}

class ItNewsCard extends StatelessWidget {
  final News news;

  const ItNewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      margin: const EdgeInsets.only(right: 20),
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
          // Image Section with aspect ratio
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
                bottom: Radius.zero,
              ),
              child: Image.network(
                news.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and Category Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      news.date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      news.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Title Section
                Text(
                  news.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                // Description Section
                Text(
                  news.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.defaultGrayColor,
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