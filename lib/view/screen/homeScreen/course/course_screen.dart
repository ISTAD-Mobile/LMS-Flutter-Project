import 'package:flutter/material.dart';
class ShortCoursePage extends StatelessWidget {
  const ShortCoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002F42),
        title: const Text("Short Course"),
      ),
      body: const Center(
        child: Text(
          "Welcome to the Short Course Page!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}