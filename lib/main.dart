import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lms_mobile/view/screen/enrollments/enrollment_provider.dart';
import 'package:lms_mobile/repository/login_repo.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';
import 'package:lms_mobile/repository/student_profile_setting_repository.dart';
import 'package:lms_mobile/view/screen/splashScreen/splash_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/enrollments_widget/enroll_step2.dart';
import 'package:lms_mobile/viewModel/course_viewmodel.dart';
import 'package:lms_mobile/viewModel/enroll/current_address_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/place_of_birth_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/university_view_model.dart';
import 'package:lms_mobile/viewModel/student_profile_viewModel.dart';
import 'package:lms_mobile/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:lms_mobile/view/widgets/sytem_screen/no_internet.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EnrollmentStateNotifier(),child: const EnrollStep2(),),
        ChangeNotifierProvider(create: (_) => LoginViewModel(LoginStudentRepository())),
        ChangeNotifierProvider(create: (_) => PlaceOfBirthViewModel()),
        ChangeNotifierProvider(create: (_) => CurrentAddressViewModel()),
        ChangeNotifierProvider(create: (_) => UniversityViewModel()),
        ChangeNotifierProvider(create: (_) => CourseViewmodel()),
        Provider<StudentProfileRepository>(create: (_) => StudentProfileRepository(accessToken: '')), // Ensure you have a valid repository
        ChangeNotifierProvider(
          create: (context) => StudenProfileDataViewModel(userRepository: context.read<StudentProfileRepository>()),
        ),
        Provider<StudentSettingRepository>(
          create: (_) => StudentSettingRepository(accessToken: ''),
        ),
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
