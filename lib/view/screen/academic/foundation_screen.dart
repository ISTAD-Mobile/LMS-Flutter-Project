import 'package:flutter/material.dart';
class FoundationPage extends StatelessWidget {
  const FoundationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002F42),
        title: const Text("Foundation"),
      ),
      body: const Center(
        child: Text(
          "Welcome to the Foundation Page!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
