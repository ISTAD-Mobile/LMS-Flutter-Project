import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';
import 'package:lms_mobile/viewModel/achievement/year_of_study_achievement_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../repository/achievement/year_of_study_achievement_repository.dart';
import '../../../../viewModel/student_profile_viewModel.dart';
import '../../../widgets/studentsWidget/lms/acheivement_year_semester.dart';

class AcheivementScreen extends StatefulWidget {
  final String token;

  AcheivementScreen({required this.token, Key? key}) : super(key: key);

  @override
  _AcheivementScreenState createState() => _AcheivementScreenState();
}

class _AcheivementScreenState extends State<AcheivementScreen> {
  late YearOfStudyAchievementViewModel viewModel;

  @override
  void initState() {
    super.initState();

    final repository = YearOfStudyAchievementRepository(
      accessToken: widget.token,
    );

    viewModel = YearOfStudyAchievementViewModel(repository: repository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              StudenProfileDataViewModel(
                userRepository: StudentProfileRepository(
                  token: widget.token,
                ),
              ),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  _buildWelcomeBanner(),
                  _buildTranscript(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Welcome Banner
  Widget _buildWelcomeBanner() {
    return Consumer<StudenProfileDataViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.user == null && !viewModel.isLoading &&
            viewModel.errorMessage == null) {
          viewModel.fetchUserData();
        }

        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.errorMessage != null) {
          return Center(child: Text("Error: ${viewModel.errorMessage}"));
        } else if (viewModel.user == null) {
          return const Center(child: Text("No user data found"));
        } else {
          final user = viewModel.user!;
          return Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.fromLTRB(0, 16, 15, 20),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 130.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back, ${user.nameEn}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Passionate about literature and creative writing.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0.0,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: user.profileImage != null &&
                        user.profileImage!.isNotEmpty
                        ? NetworkImage(user.profileImage!)
                        : const AssetImage(
                        'assets/images/placeholder.jpg') as ImageProvider,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Transcript Section
 Widget _buildTranscript() {
  return Consumer<StudenProfileDataViewModel>(
    builder: (context, viewModel, child) {
      if (viewModel.user == null) {
        return const Center(child: Text("Loading transcript..."));
      }
      final user = viewModel.user!;
      return Container(
        margin: const EdgeInsets.fromLTRB(20.0, 70.0, 20.0, 20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Center of Science and Technology Advanced Development',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            const Text(
              'OFFICIAL TRANSCRIPT',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 170,
                width: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: user.profileImage != null && user.profileImage!.isNotEmpty
                        ? NetworkImage(user.profileImage!)
                        : const AssetImage('assets/images/placeholder.jpg') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildStudentInfo(),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 500,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: IntrinsicHeight(
                child: YearOfStudyAchievementScreen(token: widget.token),
              ),
            ),
          ],
        ),
      );
    },
  );
}

  // Student Info Section
  Widget _buildStudentInfo() {
  return Consumer<StudenProfileDataViewModel>(
    builder: (context, viewModel, child) {
      if (viewModel.user == null) {
        return const Center(child: Text("Loading user data..."));
      }
      final user = viewModel.user!;
      final infoData = {
        'Name (KH)': user.nameKh,
        'Name (EN)': user.nameEn,
        'Date of Birth': user.dob,
        'Degree': user.degree,
        'Major': user.major,
      };

      return Container(
        color: Colors.white,
        child: Column(
          children: infoData.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                    width: 120,
                    child: Text(
                      entry.key,
                      style: const TextStyle(
                        color: AppColors.defaultGrayColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Text(' :  '),
                  Flexible(
                    child: Text(
                      entry.value ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.defaultGrayColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    },
  );
}
}