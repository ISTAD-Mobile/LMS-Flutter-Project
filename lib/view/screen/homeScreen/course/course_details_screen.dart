import 'package:flutter/material.dart';
import 'package:lms_mobile/viewModel/course_details_viewmodel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../data/color/color_screen.dart';
import '../../../../model/course_details_model.dart';
import '../../enrollments/enroll_screen.dart';

class CourseDetailPage extends StatelessWidget {
  final String uuid;
  CourseDetailPage({required this.uuid});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseDetailsViewmodel()..getCourseDetail(uuid),
      child: Scaffold(
        backgroundColor: AppColors.defaultWhiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.defaultWhiteColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.defaultGrayColor),
          ),
          title: const Text("Course Description",
            style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
        ),
        body: Consumer<CourseDetailsViewmodel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(
                  child: Lottie.asset(
                    'assets/animation/loading.json',
                    width: 100,
                    height: 100,
                  ),
              );
            }

            if (viewModel.errorMessage != null) {
              return Center(child: Text('Error: ${viewModel.errorMessage}'));
            }

            if (viewModel.courseDetail == null) {
              return Center(child: Text('No course details found.'));
            }

            final course = viewModel.courseDetail!.data;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Title & Description Section
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey.shade300, width: 1.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course?.title ?? 'No Title',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            course?.description ?? 'No Description',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.defaultGrayColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'COURSE OFFER',
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 2.0,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildCourseOffers(course?.offer?.details),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPriceSection(viewModel.courseDetail),
                    const SizedBox(height: 16),
                    _buildResetButton(context),
                    const SizedBox(height: 16),
                    _buildExpansionTile(course?.outline ?? []),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCourseOffers(List<String>? offers) {
    if (offers == null || offers.isEmpty) {
      return Text('No offers available.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: offers.asMap().map((index, offer) {
        return MapEntry(
          index,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. ',
                  style: const TextStyle(fontSize: 14),
                ),
                Expanded(
                  child: Text(
                    offer,
                    style: const TextStyle(fontSize: 14),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        );
      }).values.toList(),
    );
  }




  Widget _buildPriceSection(CourseDetailResponse? courseDetailResponse) {
    if (courseDetailResponse == null || courseDetailResponse.data == null) {
      return const Center(child: Text('No course details available.'));
    }

    final courseData = courseDetailResponse.data;
    final fee = courseData?.fee ?? 0.0;
    final discountedFee = fee * (1 - 0.20);
    final duration = courseData?.totalHour ;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  '20% Schoolarship',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  children: [
                    // Original price with strikethrough
                    TextSpan(
                      text: '\$${fee.toStringAsFixed(3)} ',
                      style: const TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Discounted price
                    TextSpan(
                      text: '  /  \$${discountedFee.toStringAsFixed(3)}',
                      style: TextStyle(
                        color: AppColors.defaultBlackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Duration: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.defaultBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:'$duration hours',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildResetButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => EnrollScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Enroll',
          style: TextStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTile(List<Detail> outline) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.blue,
            width: 1,
          ),
        ),
      ),
      child: Builder(
        builder: (BuildContext context) {
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Column(
              children: outline.isNotEmpty
                  ? outline.map((section) {
                return ExpansionTile(
                  title: Text(
                    section.title ?? 'Untitled',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  collapsedBackgroundColor: Colors.white,
                  iconColor: AppColors.primaryColor,
                  collapsedIconColor: Colors.blue[900],
                  tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  childrenPadding: EdgeInsets.all(0),
                  expandedAlignment: Alignment.topLeft,
                  maintainState: true,
                  trailing: const Icon(Icons.arrow_drop_down),
                  leading: Icon(Icons.menu_book_outlined, color: Colors.blue[900]),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Check if details is available and non-empty
                          section.details != null && section.details!.isNotEmpty
                              ? Column(
                            children: section.details!
                                .map((detailItem) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    child: Icon(
                                      Icons.circle,
                                      size: 6,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      detailItem,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                                .toList(),
                          )
                              : const Text('No details available.'),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList()
                  : [Text('No outline available.')],
            ),
          );
        },
      ),
    );
  }



}


