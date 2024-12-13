import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'It_news_card.dart';
import 'it_news_detail.dart';

class ItNewsSection extends StatelessWidget {
  const ItNewsSection({Key? key}) : super(key: key);

  void _launchURL() async {
    const url = 'https://www.facebook.com/istad.co?mibextid=ZbWKwL';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          GestureDetector(
            onTap: _launchURL,
            child: const Text(
              'See more',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
          const SizedBox(height: 16),
          SizedBox(
            height: 330,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: news.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItNewsDetail(news: news[index]),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: ItNewsCard(news: news[index]),
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
