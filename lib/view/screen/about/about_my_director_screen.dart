import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text section
              const Text(
                'សាររបស់លោកនាយក',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'NotoSansKhmer',
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.defaultGrayColor,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: 'កាលពីបីឆ្នាំមុន ក្នុងឆ្នាំ 2020 ខ្ញុំបាទ ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NotoSansKhmer',
                      ),

                    ),
                    TextSpan(
                      text: ' ចិន ភីរម្យ',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'NotoSansKhmer',
                      ),
                    ),
                    TextSpan(
                      text: ' នាយករបស់ '
                      ,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NotoSansKhmer',
                      ),
                    ),
                    TextSpan(
                      text: ' មជ្ឈមណ្ឌល សាយអិនស៍ អេន ថេកណឡជី អ៊ែតវ៉ានស៍ ឌីវេឡុបម៉ិន (iSTAD) ',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'NotoSansKhmer',
                      ),
                    ),
                    TextSpan(
                      text: 'និងគណៈកម្មារការក្រុមប្រឹក្សាភិបាលផ្សេងទៀតបានពិភាក្សាអំពីការបើកកន្លែងមួយដែលនឹងនាំនិស្សិតកម្ពុជាទៅរកវិទ្យាសាស្ត្រ និងបច្ចេកវិទ្យាកម្រិតខ្ពស់មួយ ដែលរួមមានទាំងការស្រាវជ្រាវ និងការអភិវឌ្ឍជំនាញឌីជីថល ជាមួយនឹងការធានាឱកាសការងារដ៏ល្អដល់ និស្សិតដែលបានបញ្ចប់ការសិក្សា ទៅតាមស្ថាប័នរដ្ឋនិងឯកជន។ កិច្ចពិភាក្សាបានបញ្ចប់ដោយការសម្រេចចិត្តបើកស្ថាប័នអប់រំដែលនឹងផ្តល់ផលវិជ្ជមាន និងការរីកចម្រើនដល់ធនធានមនុស្សផ្នែកឌីជីថល និងលើកកម្ពស់វិស័យ ICT ក្នុងប្រទេសម្ពុជាដើម្បី ឱ្យសមស្របទៅតាមផែនការយុទ្ធសាស្រ្តរបស់រាជ្យរដ្ឋាភិបាលកម្ពុជា។ ក្នុងនាមខ្ញុំជានាយករបស់ iSTAD ខ្ញុំសូមស្វាគមន៍យ៉ាងកក់ក្តៅដល់អ្នកទាំងអស់គ្នាដែលបានក្លាយនិស្សិតជំនាន់ទី2 នៃកម្មវិធីបណ្តុះបណ្តាលអាហារូបករណ៍ព័ត៌មានវិទ្យារបស់ iSTAD។ ខ្ញុំសូមយកឱកាសនេះដើម្បីអបអរសាទរដល់អ្នក',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NotoSansKhmer',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                // mainAxisSpacing: 10,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                List<String> imagePaths = [
                  'assets/images/about_our_director1.png',
                  'assets/images/about_our_director2.png',
                  'assets/images/about_our_director3.png',
                  'assets/images/about_our_director4.png',
                ];

                List<Size> imageSizes = [
                  Size(300, 200),
                  Size(400, 200),
                  Size(150, 200),
                  Size(300, 300),
                ];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Container(
                    alignment: Alignment.center,
                    width: imageSizes[index].width,
                    height: imageSizes[index].height,
                    child: Image.asset(
                      imagePaths[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),
              const Column(
                children: [
                  Text('ទាំងអស់គ្នាដែលបានទទួលអាហារូបករណ៍របស់ iSTAD ដោយជោគជ័យ។ នេះគឺជាសមិទ្ធិផលដ៏អស្ចារ្យមួយ ហើយវាគឺជាសក្ខីភាពបញ្ជាក់ពីការខិតខំប្រឹងប្រែង ការលះបង់ និងការប្តេជ្ញាចិត្តចំពោះការសិក្សារបស់អ្នកទាំងអស់គ្នា។ នៅក្នុងយុគសម័យឌីជីថលនាពេលបច្ចុប្បន្ននេះ បច្ចេកវិទ្យាបានដើរតួនាទីយ៉ាងសំខាន់ក្នុងជីវិតប្រចាំថ្ងៃរបស់យើង ហើយក្នុងនាមអ្នក ជាអ្នកដឹកនាំនាពេលអនាគត អ្នកមាន តួនាទីយ៉ាងសំខាន់ក្នុងការសម្រួចខ្លួនឱ្យស្របទៅតាមទិសដៅនៃចក្ខុវិស័យមួយនេះ មិនថាអ្នកកំពុងបន្តអាជីពផ្នែកព័ត៌មានវិទ្យា ឬគ្រាន់តែប្រើប្រាស់បច្ចេកវិទ្យាដើម្បីសម្រួលនៅក្នុងការរស់នៅផ្ទាល់ខ្លួនតែប៉ុណ្ណោះទេ ចំណេះដឹង ជំនាញ និងអាជីពរបស់អ្នកគឺមានតម្លៃមិនអាចកាត់ថ្លៃបានទេ។ នៅពេលអ្នកចាប់ផ្តើមសិក្សាផ្នែក IT ខ្ញុំសូមលើកទឹកចិត្តអ្នកឱ្យបើកចិត្តឱ្យបានទូលាយដើម្បីស្វែងរកបញ្ហាប្រឈមថ្មីៗ ដែលអ្នកត្រូវស្វែងយល់ពីបច្ចេកវិទ្យាដែលកំពុងរីកចម្រើន',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'NotoSansKhmer',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Container(
                child:
                Image.asset("assets/images/about_our_director5.png"),
              ),

              const SizedBox(height: 20),
              const Column(
                children: [
                  Text("ហើយសហការជាមួយមិត្តភ័ក្តិ និងក្រុមការងាររបស់អ្នក ពិសេស លោកគ្រូ អ្នកគ្រូ ដែលអាចដឹកនាំអ្នក ទៅកាន់ក្តីស្រមៃរបស់អ្នក។ និស្សិត iSTAD ទាំងអស់មិនត្រឹមតែត្រូវបានបណ្តុះបណ្តាលជាមួយនឹងជំនាញបច្ចេកទេសទំនើបប៉ុណ្ណោះទេ ប៉ុន្តែថែមទាំង ត្រូវបានបង្រៀនឱ្យមានការប្តេជ្ញាចិត្តខ្ពស់ មានភាពជាអ្នកដឹកនាំ ការសហការជាក្រុម ឯករាជ្យភាព ទំនួលខុសត្រូវ ខ្ពស់ និងក្លាយជាអ្នក ចែករំលែកដល់អ្នកដទៃ ដ៏ឆ្នើមមួយរូប។ ជាមួយគ្នានេះ ខ្ញុំក៏ចង់សង្កត់ធ្ងន់អំពីសារៈសំខាន់នៃការកសាងមូលដ្ឋានគ្រឹះដ៏រឹងមាំនៅក្នុងផ្នែកព័ត៌មានវិទ្យា ។ គោលគំនិតស្នូលនៃវិទ្យាសាស្ត្រកុំព្យូទ័រ ការសរសេរកម្មវិធី និងការវិភាគទិន្នន័យនឹងផ្តល់ឱ្យអ្នកនូវគ្រឹះដ៏រឹងមាំមួយសម្រាប់កសាងចំណេះដឹង និងជំនាញរបស់អ្នក ហើយនឹងជួយអ្នកបានយ៉ាងល្អពេញមួយអាជីពរបស់អ្នក។ iSTAD នឹងក្លាយជាវិទ្យាស្ថានព័ត៌មានវិទ្យាកម្រិតខ្ពស់មួយដែលមាន បេសកកម្មក្នុងការផ្តល់នូវវិធីសាស្រ្តបង្រៀនថ្មីៗ ជាមួយនឹងការបណ្តុះបណ្តាល និងការតម្រង់ទិសប្រកបដោយគុណភាពខ្ពស់ ដើម្បីបង្កើតសមត្ថភាព និងអាជីពរបស់អ្នកជំនាញព័ត៌មានវិទ្យានៅកម្ពុជា, ការផ្តល់ការប្រឹក្សា និងការផ្សាភ្ជាប់សិក្ខាកាមរបស់ iSTAD ទៅកាន់អាជីពព័ត៌មានវិទ្យាឈានមុខ ហើយតែងតែជាកន្លែងដែលអ្នកអាចរីកចម្រើនដោយខ្លួនឯង និងប្រកបដោយវិជ្ជាជីវៈ ដើម្បីសម្រេចបាននូវក្តីសុបិនរបស់អ្នក និងក្លាយជាគម្រូដ៏ល្អបំផុតសម្រាប់ខ្លួនអ្នក។ ជាចុងក្រោយ ខ្ញុំសូមធានាដល់អ្នកទាំងអស់គ្នាថា iSTAD នឹងនៅជាមួយអ្នក គាំទ្រអ្នកគ្រប់ជំហាន។ យើងមានក្រុមសាស្ត្រាចារ្យ និងបុគ្គលិកដែលមានទេពកោសល្យ ជំនាញវិជ្ជាជីវៈពិតប្រាកដ ដែលមានការប្តេជ្ញាចិត្តចំពោះភាពជោគជ័យរបស់អ្នក ហើយយើងនិងផ្តល់ជូននូវធនធាន និងការគាំទ្រជាច្រើន ដើម្បីជួយអ្នកឱ្យសម្រេចបាននូវគោលដៅរបស់អ្នក។ ពិសេសមានដៃគូសហប្រតិបត្តិការ ជាច្រើន ទាំងស្ថាប័នរដ្ឋ និង ឯកជន ទទួលយកអ្នក នៅពេលដែលបញ្ចប់ការសិក្សា និង មានឱកាស អភិវឌ្ឍន៍ ចំណេះដឹង ឱ្យកាន់តែខ្ពស់ ក្នុងកម្រិតថ្នាក់អនុបណ្ឌិត បណ្ឌិត នៅ បរទេសទៀតផង។",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'NotoSansKhmer',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 5,
                shadowColor: Colors.black.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/about_our_director1.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Text(
                            'លោក ចិន ភីរម្យ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              fontFamily: 'NotoSansKhmer',
                            ),
                          ),
                          SizedBox(width: 8),
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 512 512">
                                <path fill="#ffb636" d="m252.5 381l-128 49c-5.9 2.2-12.1-2.3-11.8-8.6l7-136.9c.1-2.1-.6-4.2-1.9-5.9L31.6 172c-4-4.9-1.6-12.2 4.5-13.9l132.4-35.6c2.1-.6 3.9-1.9 5-3.7L248.3 4c3.4-5.3 11.2-5.3 14.6 0l74.8 114.9c1.2 1.8 3 3.1 5 3.7l132.4 35.6c6.1 1.6 8.5 9 4.5 13.9l-86.1 106.6c-1.3 1.7-2 3.8-1.9 5.9l7 136.9c.3 6.3-5.9 10.8-11.8 8.6l-128-49c-2.1-.8-4.3-.8-6.3-.1" />
                                <path fill="#ffd469" d="m456.1 51.7l-41-41c-1.2-1.2-2.8-1.7-4.4-1.5s-3.1 1.2-3.9 2.6l-42.3 83.3c-1.2 2.1-.8 4.6.9 6.3c1 1 2.4 1.5 3.7 1.5c.9 0 1.8-.2 2.6-.7L454.9 60c1.4-.8 2.4-2.2 2.6-3.9c.3-1.6-.3-3.2-1.4-4.4m-307 43.5l-42.3-83.3c-.8-1.4-2.2-2.4-3.9-2.6c-1.6-.2-3.3.3-4.4 1.5l-41 41c-1.2 1.2-1.7 2.8-1.5 4.4s1.2 3.1 2.6 3.9l83.3 42.3c.8.5 1.7.7 2.6.7c1.4 0 2.7-.5 3.7-1.5c1.7-1.8 2-4.4.9-6.4m140.7 410l-29-88.8c-.2-.9-.7-1.7-1.3-2.3c-1-1-2.3-1.5-3.7-1.5c-2.4 0-4.4 1.6-5.1 3.9l-29 88.8c-.4 1.6-.1 3.3.9 4.6s2.5 2.1 4.2 2.1h57.9c1.6 0 3.2-.8 4.2-2.1c1.1-1.4 1.4-3.1.9-4.7" />
                              </svg>''',
                            height: 18,
                            width: 18,
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        '“ ការផ្តល់ឱកាសឱ្យខ្លួនឯងជារឿងទីមួយ ការស្វែករកឱកាសជារឿងទីពីរ ការចាប់ឱកាសជារឿងទីបី គោលដៅមិនដែលដូរទេ ជាទូទៅខ្លួនអ្នកជាអ្នកផ្លាស់ប្តូរគោលដៅ ”',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'NotoSansKhmer',
                        ),
                      ),

                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
                                <g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2">
                                  <path d="M8 13V4.5a1.5 1.5 0 0 1 3 0V12m0-.5v-2a1.5 1.5 0 0 1 3 0V12m0-1.5a1.5 1.5 0 0 1 3 0V12" />
                                  <path d="M17 11.5a1.5 1.5 0 0 1 3 0V16a6 6 0 0 1-6 6h-2h.208a6 6 0 0 1-5.012-2.7L7 19q-.468-.718-3.286-5.728a1.5 1.5 0 0 1 .536-2.022a1.87 1.87 0 0 1 2.28.28L8 13M5 3L4 2m0 5H3m11-4l1-1m0 4h1" />
                                </g>
                              </svg>''',
                            height: 18,
                            width: 18,
                            color: AppColors.secondaryColor,
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () async {
                              const url = 'https://www.facebook.com/chen.phirum.9?mibextid=ZbWKwL';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const Text(
                              'ពាក្យស្លោករបស់លោកគ្រូនាយក។',
                              style: TextStyle(fontSize: 14, color: AppColors.primaryColor99,fontWeight: FontWeight.w700,
                                fontFamily: 'NotoSansKhmer',
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 15),
                            child: Container(
                              height: 2,
                              width: 230,
                              color: AppColors.primaryColor99,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
