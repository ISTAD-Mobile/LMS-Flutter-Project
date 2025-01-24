import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms_mobile/repository/enroll/enroll_repository.dart';
import 'package:lms_mobile/repository/enroll/enroll_step3_repo.dart';
import 'package:lms_mobile/repository/login_repo.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';
import 'package:lms_mobile/repository/student_profile_setting_repository.dart';
import 'package:lms_mobile/view/screen/splashScreen/splash_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/enrollments_widget/enrollment_provider.dart';
import 'package:lms_mobile/viewModel/admission/degree_viewmodel.dart';
import 'package:lms_mobile/viewModel/admission/shift_viewmodel.dart';
import 'package:lms_mobile/viewModel/admission/study_program_alas.dart';
import 'package:lms_mobile/viewModel/course_details_viewmodel.dart';
import 'package:lms_mobile/viewModel/course_viewmodel.dart';
import 'package:lms_mobile/viewModel/enroll/available_course_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/current_address_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/enroll_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/enrollment_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/place_of_birth_view_model.dart';
import 'package:lms_mobile/viewModel/enroll/university_view_model.dart';
import 'package:lms_mobile/viewModel/jobvacancy_detail_viewmodel.dart';
import 'package:lms_mobile/viewModel/student_profile_viewModel.dart';
import 'package:lms_mobile/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:lms_mobile/view/widgets/sytem_screen/no_internet.dart';
import 'data/color/color_screen.dart';
import 'data/network/enrollment_service.dart';

void main() {
  final enrollmentService = EnrollmentService();
  final enrollmentRepository = EnrollmentRepository(enrollmentService);
  final enrollRepository = EnrollRepository(enrollmentService);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EnrollmentStateNotifier()),
        ChangeNotifierProvider(create: (_) => LoginViewModel(LoginStudentRepository())),
        ChangeNotifierProvider(create: (_) => PlaceOfBirthViewModel()),
        ChangeNotifierProvider(create: (_) => CurrentAddressViewModel()),
        ChangeNotifierProvider(create: (_) => UniversityViewModel()),
        ChangeNotifierProvider(create: (_) => ShiftViewModel()),
        ChangeNotifierProvider(create: (_) => DegreeViewModel()),
        ChangeNotifierProvider(create: (_) => CourseViewmodel()),
        ChangeNotifierProvider(create: (_) => StudyProgramAlasViewModel()),
        ChangeNotifierProvider(create: (_) => CourseDetailsViewmodel()),
        ChangeNotifierProvider(create: (_) => JobvacancyDetailViewmodel()),
        ChangeNotifierProvider(create: (context) => AvailableCourseViewModel()),
        ChangeNotifierProvider(
          create: (_) => EnrollmentViewModel(enrollmentRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => EnrollViewModel(enrollRepository),
        ),
        Provider<StudentProfileRepository>(create: (_) => StudentProfileRepository(token: '')),
        Provider<StudentSettingRepository>(create: (_) => StudentSettingRepository(token: '')),
        ChangeNotifierProvider(
          create: (context) => StudenProfileDataViewModel(
              userRepository: context.read<StudentProfileRepository>()),
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
  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    super.initState();
    connectivityStream = Connectivity().onConnectivityChanged;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);

          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            Fluttertoast.showToast(
              msg: 'Press back again to exit',
              fontSize: 18,
              textColor: AppColors.primaryColor,
            );
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: StreamBuilder<List<ConnectivityResult>>(
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
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: const Center(child: Text('No connectivity data available')),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}