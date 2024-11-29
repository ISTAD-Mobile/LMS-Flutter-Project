import 'package:flutter/material.dart';
class AssociatePage extends StatelessWidget {
  const AssociatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002F42),
        title: const Text("Associate"),
      ),
      body: const Center(
        child: Text(
          "Welcome to the Associate Page!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}