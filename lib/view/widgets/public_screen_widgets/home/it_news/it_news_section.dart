import 'package:flutter/material.dart';
import 'package:lms_mobile/viewModel/JobVacancyViewmodel.dart';
import 'package:provider/provider.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/widgets/public_screen_widgets/home/it_news/it_news_card.dart';
import 'package:lms_mobile/data/response/status.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => JobvacancyViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Course App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ItNewsSection(),
      ),
    );
  }
}

class ItNewsSection extends StatefulWidget {
  const ItNewsSection({Key? key}) : super(key: key);

  @override
  _ItNewsSectionState createState() => _ItNewsSectionState();
}

class _ItNewsSectionState extends State<ItNewsSection> {
  late JobvacancyViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<JobvacancyViewModel>(context, listen: false);
    _viewModel.fetchAllJobvacancy();
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
                'Useful Content'.toUpperCase(),
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
          Builder(
            builder: (context) {
              switch (_viewModel.jobvacancy.status!) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.COMPLETED:
                  final jobvacancys = _viewModel.jobvacancy.data?.dataList ?? [];
                  return jobvacancys.isEmpty
                      ? Center(child: Text('No Jobvacancy available'))
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
                  return Center(
                    child: Text(
                      'An error occurred: ${_viewModel.jobvacancy.message}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                default:
                  return const Center(child: Text('Unknown status'));
              }
            },
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
