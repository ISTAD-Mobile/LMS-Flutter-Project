import 'package:flutter/material.dart';
import 'package:lms_mobile/view/Skelaton/homepageSkeleton/jobVacancySkeleton.dart';
import 'package:lms_mobile/viewModel/JobVacancyViewmodel.dart';
import 'package:provider/provider.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/it_news/it_news_card.dart';
import 'package:lms_mobile/data/response/status.dart';
import 'package:url_launcher/url_launcher.dart';

class ItNewsSection extends StatefulWidget {
  const ItNewsSection({Key? key}) : super(key: key);

  @override
  _ItNewsSectionState createState() => _ItNewsSectionState();
}

class _ItNewsSectionState extends State<ItNewsSection> {
  final jobvacancyViewModel = JobvacancyViewModel();

  @override
  void initState() {
    super.initState();
    jobvacancyViewModel.fetchAllJobvacancy();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Short Course'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              GestureDetector(
                onTap: _launchURL,
                child: const Text(
                  'See More',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ChangeNotifierProvider(
            create: (context) => jobvacancyViewModel,
            child: Consumer<JobvacancyViewModel>(builder: (context, viewModel, _) {
              final status = viewModel.jobvacancy.status;
              if (status == null) {
                return Center(child: Text('Status is null'));
              }
              switch (status) {
                case Status.LOADING:
                  return SizedBox(
                    height: 170,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) => Jobvacancyskeleton(),
                      separatorBuilder: (context, index) => SizedBox(width: 8),
                    ),
                  );
                case Status.COMPLETED:
                  final jobvacancys = viewModel.jobvacancy.data?.dataList ?? [];
                  return jobvacancys.isEmpty
                      ? Center(child: Text('No courses available'))
                      : SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: jobvacancys.length,
                      itemBuilder: (context, index) {
                        final jobvacancy = jobvacancys[index];
                        return ItNewsCard(jobVacancy: jobvacancy);
                      },
                    ),
                  );

                case Status.ERROR:
                  return Center(
                    child: Text(
                      'An error occurred: ${viewModel.jobvacancy.message ?? 'Unknown error'}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
              }
            }),
          ),
        ],
      ),
    );
  }

  void _launchURL() async {
    final url = Uri.parse('https://www.facebook.com/istad.co?mibextid=ZbWKwL');
    print("Launching URL: $url");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $url");
    }
  }
}
