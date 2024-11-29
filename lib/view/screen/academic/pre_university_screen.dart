import 'package:flutter/material.dart';

class PreUniversityPage extends StatelessWidget {
  const PreUniversityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002F42),
        title: const Text("Pre-University"),
      ),
      body: const Center(
        child: Text(
          "Welcome to the Pre-University Page!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
