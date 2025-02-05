import 'package:flutter/material.dart';
import 'package:lms_mobile/repository/student_profile_repository.dart';
import 'package:lms_mobile/viewModel/achievement/year_of_study_achievement_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
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
            child: Column(
              children: [
                _buildWelcomeBanner(),
                _buildTranscript(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Consumer<StudenProfileDataViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.user == null && !viewModel.isLoading &&
            viewModel.errorMessage == null) {
          viewModel.fetchUserData();
        }
        if (viewModel.isLoading) {
          return _buildWelcomeBannerAchievementSkeleton();
        } else if (viewModel.errorMessage != null) {
          return Center(child: Text("Error: ${viewModel.errorMessage}"));
        } else if (viewModel.user == null) {
          return const Center(child: Text("No user data found"));
        } else {
          final user = viewModel.user!;
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.fromLTRB(0, 16, 15, 20),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 115.0),
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
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 0.0,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: user.profileImage != null &&
                        user.profileImage!.isNotEmpty
                        ? NetworkImage(user.profileImage!)
                        : const AssetImage(
                        'assets/images/placeholder.jpg') as ImageProvider,
                  ),
                ),
                Positioned(
                    top: 95,
                    left: 115.0,
                    child: Column(
                      children: [
                        Text(user.nameEn,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildTranscript() {
    return Consumer<StudenProfileDataViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.user == null) {
          return _buildSkeleton();
        }
        final user = viewModel.user!;

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
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
              const SizedBox(height: 10),
              Text(
                'Official Transcript'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.defaultBlackColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
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
              SizedBox(height: 10),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 500,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: YearOfStudyAchievementScreen(token: widget.token),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkeleton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
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
          _buildShimmerText(120), // Skeleton for title
          const SizedBox(height: 10),
          _buildShimmerText(100), // Skeleton for subtitle
          const SizedBox(height: 20),
          _buildShimmerImage(), // Skeleton for image
          const SizedBox(height: 20),
          _buildShimmerText(200), // Skeleton for other content
          const SizedBox(height: 10),
          _buildShimmerText(200), // Skeleton for other content
        ],
      ),
    );
  }

  Widget _buildShimmerText(double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 20.0,
        width: width,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _buildShimmerImage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 170,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.grey[300], // Skeleton color
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Student Info Section
  Widget _buildStudentInfo() {
    return Consumer<StudenProfileDataViewModel>(builder: (context, viewModel, child) {
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
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.defaultGrayColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: entry.key == 'Name (KH)' ? 'NotoSansKhmer' : null, // Apply fontFamily only for Khmer name
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }

}

Widget _buildWelcomeBannerAchievementSkeleton() {
  return Container(
    height: 100,
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.fromLTRB(0, 16, 15, 16),
    decoration: BoxDecoration(
      color: AppColors.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Placeholder for text content inside the banner
        Padding(
          padding: const EdgeInsets.only(left: 115.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for 'Welcome back'
              Container(
                height: 16,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
        // Placeholder for Circle Avatar
        Positioned(
          top: 30,
          left: 0,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white.withOpacity(0.3),
          ),
        ),
        // Placeholder for name and courses
        Positioned(
          top: 95,
          left: 115.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16,
                width: 150,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}