import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lms_mobile/view/screen/splashScreen/splash_screen.dart';
import 'package:lms_mobile/viewModel/course_viewmodel.dart';
import 'package:lms_mobile/viewModel/enroll/current_address_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/place_of_birth_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/university_view_model.dart';
import 'package:lms_mobile/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:lms_mobile/view/widgets/sytem_screen/no_internet.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => PlaceOfBirthViewModel()),
        ChangeNotifierProvider(create: (_) => CurrentAddressViewModel()),
        ChangeNotifierProvider(create: (_) => UniversityViewModel()),
        ChangeNotifierProvider(create: (_) => CourseViewmodel()),
      ],
      child: MyApp(),
    ),
  );
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
    connectivityStream = Connectivity().onConnectivityChanged;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
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
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        }

        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(child: Text('No connectivity data available')),
          ),
        );
      },
    );
  }
}
