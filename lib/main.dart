import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms_mobile/repository/enroll/enroll_repository.dart';
import 'package:lms_mobile/repository/enroll/enroll_step3_repo.dart';
import 'package:lms_mobile/repository/login_repo.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';
import 'package:lms_mobile/repository/student_profile_setting_repository.dart';
import 'package:lms_mobile/repository/student_role_repos/course_detail_repo.dart';
import 'package:lms_mobile/view/screen/splashScreen/splash_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/enrollments_widget/enroll_step2.dart';
import 'package:lms_mobile/viewModel/achievement/year_of_study_achievement_viewmodel.dart';
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
import 'package:lms_mobile/viewModel/student_profile_setting_viewmodel.dart';
import 'package:lms_mobile/viewModel/student_profile_viewModel.dart';
import 'package:lms_mobile/viewModel/login_view_model.dart';
import 'package:lms_mobile/viewModel/student_role_view_model/course_detail_view-model.dart';
import 'package:provider/provider.dart';
import 'package:lms_mobile/view/widgets/sytem_screen/no_internet.dart';
import 'data/color/color_screen.dart';
import 'data/network/enrollment_service.dart';
import 'data/network/student_role_services/course_detail_service.dart';

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
        Provider<StudentProfileRepository>(create: (_) => StudentProfileRepository(token: '')),
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
          create: (context) => StudentCourseDetailsViewModel(
            repository: StudentCourseDetailsRepository(token: ''),
          ),
        ),
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
  late final Stream<ConnectivityResult> connectivityStream;
  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    super.initState();

    connectivityStream = Connectivity()
        .onConnectivityChanged
        .map((list) => list.isNotEmpty ? list.first : ConnectivityResult.none);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: connectivityStream,
      builder: (context, snapshot) {
        Widget homeWidget = const SplashScreen();

        if (snapshot.connectionState == ConnectionState.waiting) {
          homeWidget = const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          homeWidget = Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData && snapshot.data == ConnectivityResult.none) {
          homeWidget = NoInternetPage();
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WillPopScope(
            onWillPop: () async {
              final difference = DateTime.now().difference(timeBackPressed);
              final isExitWarning = difference >= const Duration(seconds: 2);

              timeBackPressed = DateTime.now();

              if (isExitWarning) {
                Fluttertoast.showToast(
                  msg: 'Press back again to exit',
                  fontSize: 18,
                  textColor: Colors.blue, // Change to your app's primary color
                );
                return false;
              } else {
                Fluttertoast.cancel();
                return true;
              }
            },
            child: homeWidget,
          ),
        );
      },
    );
  }
}
