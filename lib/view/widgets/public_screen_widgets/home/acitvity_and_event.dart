import 'package:flutter/material.dart';

class ActivityModel {
  final String title;
  final String description;
  final String imageUrl;

  ActivityModel({required this.title, required this.description, required this.imageUrl});
}

final List<ActivityModel> activity = [
  ActivityModel(
    title: 'Closing Ceremony',
    description: 'ISTAD always prepares the closing\nceremony at the end of the basic course\nand advanced course of ITE generation.',
    imageUrl: 'assets/images/activity_and_event1.png',
  ),
  ActivityModel(
    title: 'Entrance Exam',
    description: 'Your ultimate resource for preparing\nand excelling in entrance exams.',
    imageUrl: 'assets/images/activity_and_event1.png',
  ),
  ActivityModel(
    title: 'Interview',
    description: 'Achieve interview success with our\nextensive collection of resources. ',
    imageUrl: 'assets/images/activity_and_event1.png',
  ),
  ActivityModel(
    title: 'Orientation Day',
    description: 'Your essential guide to Orientation Day!\nDiscover everything you need to know\nabout campus life, activities.',
    imageUrl: 'assets/images/activity_and_event_orientation.png',
  ),
  ActivityModel(
    title: 'Workshop',
    description: 'Immerse yourself in an enriching\nworkshop experience. Gain practical\nskills, hands-on learning, and valuable\ninsights from industry experts.',
    imageUrl: 'assets/images/activity_and_event1.png',
  ),
  ActivityModel(
    title: 'Special Lecture',
    description: 'Join our distinguished special lecture\nseries featuring renowned speakers\nand thought leaders.',
    imageUrl: 'assets/images/activity_and_event1.png',
  ),
];

class ActivityAndEventCard extends StatelessWidget {
  final ActivityModel activityModel;

  ActivityAndEventCard({required this.activityModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  activityModel.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activityModel.title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      activityModel.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
