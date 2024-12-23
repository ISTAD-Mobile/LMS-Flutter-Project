// import 'package:flutter/material.dart';
// import 'package:lms_mobile/view/screen/splashScreen/splash_screen.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreenPage(),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lms_mobile/view/screen/splashScreen/splash_screen.dart';
import 'package:lms_mobile/view/widgets/sytem_screen/no_internet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Stream<List<ConnectivityResult>> connectivityStream;

  @override
  void initState() {
    super.initState();
    connectivityStream = Connectivity().onConnectivityChanged;  // Stream<List<ConnectivityResult>>
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            ),
          );
        }

        if (snapshot.hasData) {
          // Access the first connectivity result in the list
          ConnectivityResult connectivityResult = snapshot.data![0];

          if (connectivityResult == ConnectivityResult.none) {
            // No internet connection
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: NoInternetPage(),
            );
          }

          // Internet available
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreenPage(),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(child: Text('No connectivity data available')),
          ),
        );
      },
    );
  }
}
