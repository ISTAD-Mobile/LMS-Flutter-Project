import 'package:flutter/material.dart';

class StudentCoursesScreenSkeleton extends StatelessWidget {
  const StudentCoursesScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 150,
                    height: 15,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
