import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/acitvity_and_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity & Event',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ActivityAndEventPage(),
    );
  }
}

class ActivityAndEventPage extends StatefulWidget {
  const ActivityAndEventPage({Key? key}) : super(key: key);

  @override
  _ActivityAndEventPageState createState() => _ActivityAndEventPageState();
}

class _ActivityAndEventPageState extends State<ActivityAndEventPage> {
  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          "Activities And Event", style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
                child: Row(
                  children: activity.map((activityModel) {
                    return Container(
                      padding: EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: 330,
                        height: 208,
                        child: ActivityAndEventCard(activityModel: activityModel),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.network('https://www.cstad.edu.kh/_next/image?url=https%3A%2F%2Flms-api.istad.co%2Fapi%2Fv1%2Fmedias%2Fview%2Fce1b64c8-4d56-45b0-bfcc-5b31011b4935.png&w=1920&q=75'),
                  SizedBox(height: 20),
                  Image.network('https://www.cstad.edu.kh/_next/image?url=https%3A%2F%2Flms-api.istad.co%2Fapi%2Fv1%2Fmedias%2Fview%2Ff6063869-adb8-416e-88af-88da5a25c207.png&w=1920&q=75'),
                  SizedBox(height: 20),
                  Image.network('https://www.cstad.edu.kh/_next/image?url=https%3A%2F%2Flms-api.istad.co%2Fapi%2Fv1%2Fmedias%2Fview%2Fdd037a0c-beac-4987-8983-8de0c4f86a71.png&w=1920&q=75'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
