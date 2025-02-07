import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      home: NoInternetPage(),
    );
  }
}

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/No_internet.json',
              width: 300,
              height: 300,
              fit: BoxFit.fill,
              repeat: true,
              reverse: true,
              animate: true,
            ),
            const SizedBox(height: 20),
            const Text(
              'Check your Internet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
