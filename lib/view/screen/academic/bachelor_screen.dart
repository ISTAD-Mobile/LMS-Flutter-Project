import 'package:flutter/material.dart';

class BachelorPage extends StatelessWidget {
  const BachelorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002F42),
        title: const Text("Bachelor"),
      ),
      body: const Center(
        child: Text(
          "Welcome to the Bachelor Page!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}