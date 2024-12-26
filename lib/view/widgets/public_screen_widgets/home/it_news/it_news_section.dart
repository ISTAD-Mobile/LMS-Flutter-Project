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
    jobvacancyViewModel.getAllJobvacancy();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'IT News'.toUpperCase(),
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
          SizedBox(height: 350,
            child: ChangeNotifierProvider(
              create: (context) => jobvacancyViewModel,
              child: Consumer<JobvacancyViewModel>(
                builder: (context ,viewModel,_){
                  switch(viewModel.jobvacancy.status!){
                    case Status.LOADING:
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context,index ) => Jobvacancyskeleton()
                      );
                    case Status.COMPLETED:
                      final jobvacancys = viewModel.jobvacancy.data?.jobvacancyList ?? [];
                      return jobvacancys.isEmpty
                          ? Center(child: Text('No jobvacancy available'))
                          : SizedBox(
                        height: 170,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: jobvacancys.length,
                          itemBuilder: (context, index) {
                            final jobvacancy = jobvacancys[index];
                            return ItNewsCard(jobvacancy);
                          },
                        ),
                      );
                    case Status.ERROR:
                      return Center(child: Text("Error: ${viewModel.jobvacancy.message}"));
                  }
                },
              ),
            ),
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
