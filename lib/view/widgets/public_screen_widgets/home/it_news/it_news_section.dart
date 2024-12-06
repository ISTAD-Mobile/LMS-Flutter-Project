import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

import 'It_news_card.dart';
import 'it_news_detail.dart';

class ItNewsSection extends StatelessWidget {
  const ItNewsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Useful Content'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const Text(
                'see more',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320, // Adjusted height for the list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: news.length, // Use the `news` list
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the detail screen when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItNewsDetail(news: news[index]),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 16), // Optional spacing between cards
                    child: ItNewsCard(news: news[index]), // Pass data to the card
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
