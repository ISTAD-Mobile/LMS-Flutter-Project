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
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.defaultGrayColor,),
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
                      style: TextStyle(
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
                          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 48 48"><path fill="currentColor" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="4" d="M24 20a7 7 0 1 0 0-14a7 7 0 0 0 0 14M6 40.8V42h36v-1.2c0-4.48 0-6.72-.872-8.432a8 8 0 0 0-3.496-3.496C35.92 28 33.68 28 29.2 28H18.8c-4.48 0-6.72 0-8.432.872a8 8 0 0 0-3.496 3.496C6 34.08 6 36.32 6 40.8"/></svg>',
                          width: 22,
                          height: 22,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${viewModel.jobvacancyDetail?.data?.publishedBy ?? 'Unknown'}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.string(
                          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M17 3.34a10 10 0 1 1-14.995 8.984L2 12l.005-.324A10 10 0 0 1 17 3.34M12 6a1 1 0 0 0-.993.883L11 7v5l.009.131a1 1 0 0 0 .197.477l.087.1l3 3l.094.082a1 1 0 0 0 1.226 0l.094-.083l.083-.094a1 1 0 0 0 0-1.226l-.083-.094L13 11.585V7l-.007-.117A1 1 0 0 0 12 6"/></svg>',
                          width: 22,
                          height: 22,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${viewModel.jobvacancyDetail?.data?.publishedAt != null ? DateFormat('yyyy-MM-dd').format(viewModel.jobvacancyDetail!.data!.publishedAt!.toLocal()) : 'Unknown'}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.string(
                          '<svg xmlns="http://www.w3.org/2000/svg" width="576" height="512" viewBox="0 0 576 512"><path fill="currentColor" d="M288 32c-80.8 0-145.5 36.8-192.6 80.6C48.6 156 17.3 208 2.5 243.7c-3.3 7.9-3.3 16.7 0 24.6C17.3 304 48.6 356 95.4 399.4C142.5 443.2 207.2 480 288 480s145.5-36.8 192.6-80.6c46.8-43.5 78.1-95.4 93-131.1c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C433.5 68.8 368.8 32 288 32M144 256a144 144 0 1 1 288 0a144 144 0 1 1-288 0m144-64c0 35.3-28.7 64-64 64c-7.1 0-13.9-1.2-20.3-3.3c-5.5-1.8-11.9 1.6-11.7 7.4c.3 6.9 1.3 13.8 3.2 20.7c13.7 51.2 66.4 81.6 117.6 67.9s81.6-66.4 67.9-117.6c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3"/></svg>',
                          width: 20,
                          height: 20,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${viewModel.jobvacancyDetail?.data?.view ?? 'No content available.'}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.string(
                          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M4.616 19q-.691 0-1.153-.462T3 17.384V6.616q0-.691.463-1.153T4.615 5h4.31q.323 0 .628.13q.305.132.522.349L11.596 7h7.789q.69 0 1.153.463T21 8.616v8.769q0 .69-.462 1.153T19.385 19z"/></svg>',
                          width: 22,
                          height: 22,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${viewModel.jobvacancyDetail?.data?.contentType!.type.toString()}',
                          style: TextStyle(fontSize: 14),
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
