import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../data/color/color_screen.dart';
import '../../../../../viewModel/jobvacancy_detail_viewmodel.dart';

class ItNewsDetail extends StatefulWidget {
  final int id;
  const ItNewsDetail({Key? key, required this.id}) : super(key: key);

  @override
  _JobvacancyDetailScreenState createState() => _JobvacancyDetailScreenState();
}

class _JobvacancyDetailScreenState extends State<ItNewsDetail> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<JobvacancyDetailViewmodel>(context, listen: false)
          .getJobvacancyDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobvacancyDetailViewmodel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.defaultWhiteColor,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryColor,),
            ),
            title: const Text("IT News",
              style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
            ),
          ),
          backgroundColor: AppColors.defaultWhiteColor,
          body: viewModel.isLoading
              ? Center(child: Lottie.asset(
            'assets/animation/loading.json',
            width: 100,
            height: 100,
          ),)
              : viewModel.errorMessage != null
              ? Center(child: Text(viewModel.errorMessage!))
              : Padding(
            padding: const EdgeInsets.only(right: 16,left: 16),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.jobvacancyDetail?.data?.title ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'NotoSansKhmer',
                        // color: AppColors.defaultGrayColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SvgPicture.string(
                          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="2"><path stroke-linejoin="round" d="M4 18a4 4 0 0 1 4-4h8a4 4 0 0 1 4 4a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2Z"/><circle cx="12" cy="7" r="3"/></g></svg>',
                          width: 22,
                          height: 22,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${viewModel.jobvacancyDetail?.data?.publishedBy ?? 'Unknown'}',
                          style: const TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.string(
                          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10s-4.477 10-10 10m0-2a8 8 0 1 0 0-16a8 8 0 0 0 0 16m1-8h4v2h-6V7h2z"/></svg>',
                          width: 22,
                          height: 22,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${viewModel.jobvacancyDetail?.data?.publishedAt != null ? DateFormat('yyyy-MM-dd').format(viewModel.jobvacancyDetail!.data!.publishedAt!.toLocal()) : 'Unknown'}',
                          style: const TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.string(
                          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="none" stroke="currentColor" stroke-width="2" d="M12 21c-5 0-11-5-11-9s6-9 11-9s11 5 11 9s-6 9-11 9Zm0-14a5 5 0 1 0 0 10a5 5 0 0 0 0-10Z"/></svg>',
                          width: 20,
                          height: 20,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${viewModel.jobvacancyDetail?.data?.view ?? 'No content available.'}',
                          style: const TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.string(
                          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M4 20q-.825 0-1.412-.587T2 18V6q0-.825.588-1.412T4 4h6l2 2h8q.825 0 1.413.588T22 8v10q0 .825-.587 1.413T20 20zm0-2h16V8h-8.825l-2-2H4zm0 0V6z"/></svg>',
                          width: 22,
                          height: 22,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${viewModel.jobvacancyDetail?.data?.contentType!.type.toString()}',
                          style: const TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    if (viewModel.jobvacancyDetail?.data?.thumbnail != null)
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            viewModel.jobvacancyDetail!.data!.thumbnail!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    SizedBox(height: 16),
                    Center(
                      child: SingleChildScrollView(
                        child: Html(
                          data: viewModel.jobvacancyDetail?.data?.editorContent ?? 'No content available.',
                          style: {
                            "div": Style(
                              textAlign: TextAlign.center,
                            ),
                            "p": Style(
                              textAlign: TextAlign.center,
                              fontFamily: 'NotoSansKhmer',
                            ),
                            "img": Style(
                              display: Display.inlineBlock,
                            ),
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
