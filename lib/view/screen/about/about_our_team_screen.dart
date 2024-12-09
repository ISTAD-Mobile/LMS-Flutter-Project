import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../data/color/color_screen.dart';

class OurTeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Our Mentors",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
              ),
              Image.asset('assets/images/about_our_team1.png'),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/about_our_team2.png',
                    width: 160,
                    height: 170,
                  ),
                  Image.asset(
                    'assets/images/about_our_team3.png',
                    width: 160,
                    height: 170,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Text(
                "Our LMS Members",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
              ),
              Image.asset('assets/images/about_our_team1.png'),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Leang Naikim',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      const SizedBox(height: 5,),
                      Container(
                        width: 140,
                        height: 3,
                        color: AppColors.accentColor,
                      ),
                      const SizedBox(height: 5,),
                      const Text('Team Leader',
                        style: TextStyle(fontSize: 16,color: AppColors.primaryColor,fontWeight: FontWeight.w600)
                      ),
                      const SizedBox(height: 5,),
                      const Text('Flutter development',
                          style: TextStyle(fontSize: 14,color: AppColors.defaultGrayColor)
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 256 256">
                                  <path fill="#1877f2" d="M256 128C256 57.308 198.692 0 128 0S0 57.308 0 128c0 63.888 46.808 116.843 108 126.445V165H75.5v-37H108V99.8c0-32.08 19.11-49.8 48.348-49.8C170.352 50 185 52.5 185 52.5V84h-16.14C152.959 84 148 93.867 148 103.99V128h35.5l-5.675 37H148v89.445c61.192-9.602 108-62.556 108-126.445" />
                                  <path fill="#fff" d="m177.825 165l5.675-37H148v-24.01C148 93.866 152.959 84 168.86 84H185V52.5S170.352 50 156.347 50C127.11 50 108 67.72 108 99.8V128H75.5v37H108v89.445A129 129 0 0 0 128 256a129 129 0 0 0 20-1.555V165z" />
                                </svg>''',
                            height: 23,
                            width: 23,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.string(
                              '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 64 64">
                                    <path fill="currentColor" d="M32 0C14 0 0 14 0 32c0 21 19 30 22 30c2 0 2-1 2-2v-5c-7 2-10-2-11-5c0 0 0-1-2-3c-1-1-5-3-1-3c3 0 5 4 5 4c3 4 7 3 9 2c0-2 2-4 2-4c-8-1-14-4-14-15q0-6 3-9s-2-4 0-9c0 0 5 0 9 4c3-2 13-2 16 0c4-4 9-4 9-4c2 7 0 9 0 9q3 3 3 9c0 11-7 14-14 15c1 1 2 3 2 6v8c0 1 0 2 2 2c3 0 22-9 22-30C64 14 50 0 32 0" />
                                  </svg>''',
                            height: 23,
                            width: 23,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 256 256">
                                <defs>
                                  <linearGradient id="logosTelegram0" x1="50%" x2="50%" y1="0%" y2="100%">
                                    <stop offset="0%" stop-color="#2aabee" />
                                    <stop offset="100%" stop-color="#229ed9" />
                                  </linearGradient>
                                </defs>
                                <path fill="url(#logosTelegram0)" d="M128 0C94.06 0 61.48 13.494 37.5 37.49A128.04 128.04 0 0 0 0 128c0 33.934 13.5 66.514 37.5 90.51C61.48 242.506 94.06 256 128 256s66.52-13.494 90.5-37.49c24-23.996 37.5-56.576 37.5-90.51s-13.5-66.514-37.5-90.51C194.52 13.494 161.94 0 128 0" />
                                <path fill="#fff" d="M57.94 126.648q55.98-24.384 74.64-32.152c35.56-14.786 42.94-17.354 47.76-17.441c1.06-.017 3.42.245 4.96 1.49c1.28 1.05 1.64 2.47 1.82 3.467c.16.996.38 3.266.2 5.038c-1.92 20.24-10.26 69.356-14.5 92.026c-1.78 9.592-5.32 12.808-8.74 13.122c-7.44.684-13.08-4.912-20.28-9.63c-11.26-7.386-17.62-11.982-28.56-19.188c-12.64-8.328-4.44-12.906 2.76-20.386c1.88-1.958 34.64-31.748 35.26-34.45c.08-.338.16-1.598-.6-2.262c-.74-.666-1.84-.438-2.64-.258c-1.14.256-19.12 12.152-54 35.686c-5.1 3.508-9.72 5.218-13.88 5.128c-4.56-.098-13.36-2.584-19.9-4.708c-8-2.606-14.38-3.984-13.82-8.41c.28-2.304 3.46-4.662 9.52-7.072" />
                              </svg>''',
                            height: 23,
                            width: 23,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/about_our_team4.png',
                    width: 150,
                    height: 170,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/about_our_team5.png',
                    width: 150,
                    height: 170,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Noun Sovanthorn',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      const SizedBox(height: 5,),
                      Container(
                        width: 140,
                        height: 3,
                        color: AppColors.accentColor,
                      ),
                      const SizedBox(height: 5,),
                      const Text('Team Member',
                          style: TextStyle(fontSize: 16,color: AppColors.primaryColor,fontWeight: FontWeight.w600)
                      ),
                      const SizedBox(height: 5,),
                      const Text('Flutter development',
                          style: TextStyle(fontSize: 14,color: AppColors.defaultGrayColor)
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 256 256">
                                  <path fill="#1877f2" d="M256 128C256 57.308 198.692 0 128 0S0 57.308 0 128c0 63.888 46.808 116.843 108 126.445V165H75.5v-37H108V99.8c0-32.08 19.11-49.8 48.348-49.8C170.352 50 185 52.5 185 52.5V84h-16.14C152.959 84 148 93.867 148 103.99V128h35.5l-5.675 37H148v89.445c61.192-9.602 108-62.556 108-126.445" />
                                  <path fill="#fff" d="m177.825 165l5.675-37H148v-24.01C148 93.866 152.959 84 168.86 84H185V52.5S170.352 50 156.347 50C127.11 50 108 67.72 108 99.8V128H75.5v37H108v89.445A129 129 0 0 0 128 256a129 129 0 0 0 20-1.555V165z" />
                                </svg>''',
                            height: 23,
                            width: 23,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 64 64">
                                    <path fill="currentColor" d="M32 0C14 0 0 14 0 32c0 21 19 30 22 30c2 0 2-1 2-2v-5c-7 2-10-2-11-5c0 0 0-1-2-3c-1-1-5-3-1-3c3 0 5 4 5 4c3 4 7 3 9 2c0-2 2-4 2-4c-8-1-14-4-14-15q0-6 3-9s-2-4 0-9c0 0 5 0 9 4c3-2 13-2 16 0c4-4 9-4 9-4c2 7 0 9 0 9q3 3 3 9c0 11-7 14-14 15c1 1 2 3 2 6v8c0 1 0 2 2 2c3 0 22-9 22-30C64 14 50 0 32 0" />
                                  </svg>''',
                            height: 23,
                            width: 23,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 256 256">
                                <defs>
                                  <linearGradient id="logosTelegram0" x1="50%" x2="50%" y1="0%" y2="100%">
                                    <stop offset="0%" stop-color="#2aabee" />
                                    <stop offset="100%" stop-color="#229ed9" />
                                  </linearGradient>
                                </defs>
                                <path fill="url(#logosTelegram0)" d="M128 0C94.06 0 61.48 13.494 37.5 37.49A128.04 128.04 0 0 0 0 128c0 33.934 13.5 66.514 37.5 90.51C61.48 242.506 94.06 256 128 256s66.52-13.494 90.5-37.49c24-23.996 37.5-56.576 37.5-90.51s-13.5-66.514-37.5-90.51C194.52 13.494 161.94 0 128 0" />
                                <path fill="#fff" d="M57.94 126.648q55.98-24.384 74.64-32.152c35.56-14.786 42.94-17.354 47.76-17.441c1.06-.017 3.42.245 4.96 1.49c1.28 1.05 1.64 2.47 1.82 3.467c.16.996.38 3.266.2 5.038c-1.92 20.24-10.26 69.356-14.5 92.026c-1.78 9.592-5.32 12.808-8.74 13.122c-7.44.684-13.08-4.912-20.28-9.63c-11.26-7.386-17.62-11.982-28.56-19.188c-12.64-8.328-4.44-12.906 2.76-20.386c1.88-1.958 34.64-31.748 35.26-34.45c.08-.338.16-1.598-.6-2.262c-.74-.666-1.84-.438-2.64-.258c-1.14.256-19.12 12.152-54 35.686c-5.1 3.508-9.72 5.218-13.88 5.128c-4.56-.098-13.36-2.584-19.9-4.708c-8-2.606-14.38-3.984-13.82-8.41c.28-2.304 3.46-4.662 9.52-7.072" />
                              </svg>''',
                            height: 23,
                            width: 23,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Heng SoThib',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      const SizedBox(height: 5,),
                      Container(
                        width: 140,
                        height: 3,
                        color: AppColors.accentColor,
                      ),
                      const SizedBox(height: 5,),
                      const Text('Team Member',
                          style: TextStyle(fontSize: 16,color: AppColors.primaryColor,fontWeight: FontWeight.w600)
                      ),
                      const SizedBox(height: 5,),
                      const Text('Flutter development',
                          style: TextStyle(fontSize: 14,color: AppColors.defaultGrayColor)
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 256 256">
                                  <path fill="#1877f2" d="M256 128C256 57.308 198.692 0 128 0S0 57.308 0 128c0 63.888 46.808 116.843 108 126.445V165H75.5v-37H108V99.8c0-32.08 19.11-49.8 48.348-49.8C170.352 50 185 52.5 185 52.5V84h-16.14C152.959 84 148 93.867 148 103.99V128h35.5l-5.675 37H148v89.445c61.192-9.602 108-62.556 108-126.445" />
                                  <path fill="#fff" d="m177.825 165l5.675-37H148v-24.01C148 93.866 152.959 84 168.86 84H185V52.5S170.352 50 156.347 50C127.11 50 108 67.72 108 99.8V128H75.5v37H108v89.445A129 129 0 0 0 128 256a129 129 0 0 0 20-1.555V165z" />
                                </svg>''',
                            height: 23,
                            width: 23,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 64 64">
                                    <path fill="currentColor" d="M32 0C14 0 0 14 0 32c0 21 19 30 22 30c2 0 2-1 2-2v-5c-7 2-10-2-11-5c0 0 0-1-2-3c-1-1-5-3-1-3c3 0 5 4 5 4c3 4 7 3 9 2c0-2 2-4 2-4c-8-1-14-4-14-15q0-6 3-9s-2-4 0-9c0 0 5 0 9 4c3-2 13-2 16 0c4-4 9-4 9-4c2 7 0 9 0 9q3 3 3 9c0 11-7 14-14 15c1 1 2 3 2 6v8c0 1 0 2 2 2c3 0 22-9 22-30C64 14 50 0 32 0" />
                                  </svg>''',
                            height: 23,
                            width: 23,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 256 256">
                                <defs>
                                  <linearGradient id="logosTelegram0" x1="50%" x2="50%" y1="0%" y2="100%">
                                    <stop offset="0%" stop-color="#2aabee" />
                                    <stop offset="100%" stop-color="#229ed9" />
                                  </linearGradient>
                                </defs>
                                <path fill="url(#logosTelegram0)" d="M128 0C94.06 0 61.48 13.494 37.5 37.49A128.04 128.04 0 0 0 0 128c0 33.934 13.5 66.514 37.5 90.51C61.48 242.506 94.06 256 128 256s66.52-13.494 90.5-37.49c24-23.996 37.5-56.576 37.5-90.51s-13.5-66.514-37.5-90.51C194.52 13.494 161.94 0 128 0" />
                                <path fill="#fff" d="M57.94 126.648q55.98-24.384 74.64-32.152c35.56-14.786 42.94-17.354 47.76-17.441c1.06-.017 3.42.245 4.96 1.49c1.28 1.05 1.64 2.47 1.82 3.467c.16.996.38 3.266.2 5.038c-1.92 20.24-10.26 69.356-14.5 92.026c-1.78 9.592-5.32 12.808-8.74 13.122c-7.44.684-13.08-4.912-20.28-9.63c-11.26-7.386-17.62-11.982-28.56-19.188c-12.64-8.328-4.44-12.906 2.76-20.386c1.88-1.958 34.64-31.748 35.26-34.45c.08-.338.16-1.598-.6-2.262c-.74-.666-1.84-.438-2.64-.258c-1.14.256-19.12 12.152-54 35.686c-5.1 3.508-9.72 5.218-13.88 5.128c-4.56-.098-13.36-2.584-19.9-4.708c-8-2.606-14.38-3.984-13.82-8.41c.28-2.304 3.46-4.662 9.52-7.072" />
                              </svg>''',
                            height: 23,
                            width: 23,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/about_our_team7.png',
                    width: 150,
                    height: 170,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/about_our_team6.png',
                    width: 150,
                    height: 170,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nhoem Tevy',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      const SizedBox(height: 5,),
                      Container(
                        width: 140,
                        height: 3,
                        color: AppColors.accentColor,
                      ),
                      const SizedBox(height: 5,),
                      const Text('Team Member',
                          style: TextStyle(fontSize: 16,color: AppColors.primaryColor,fontWeight: FontWeight.w600)
                      ),
                      const SizedBox(height: 5,),
                      const Text('Flutter development',
                          style: TextStyle(fontSize: 14,color: AppColors.defaultGrayColor)
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 256 256">
                                  <path fill="#1877f2" d="M256 128C256 57.308 198.692 0 128 0S0 57.308 0 128c0 63.888 46.808 116.843 108 126.445V165H75.5v-37H108V99.8c0-32.08 19.11-49.8 48.348-49.8C170.352 50 185 52.5 185 52.5V84h-16.14C152.959 84 148 93.867 148 103.99V128h35.5l-5.675 37H148v89.445c61.192-9.602 108-62.556 108-126.445" />
                                  <path fill="#fff" d="m177.825 165l5.675-37H148v-24.01C148 93.866 152.959 84 168.86 84H185V52.5S170.352 50 156.347 50C127.11 50 108 67.72 108 99.8V128H75.5v37H108v89.445A129 129 0 0 0 128 256a129 129 0 0 0 20-1.555V165z" />
                                </svg>''',
                            height: 23,
                            width: 23,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 64 64">
                                    <path fill="currentColor" d="M32 0C14 0 0 14 0 32c0 21 19 30 22 30c2 0 2-1 2-2v-5c-7 2-10-2-11-5c0 0 0-1-2-3c-1-1-5-3-1-3c3 0 5 4 5 4c3 4 7 3 9 2c0-2 2-4 2-4c-8-1-14-4-14-15q0-6 3-9s-2-4 0-9c0 0 5 0 9 4c3-2 13-2 16 0c4-4 9-4 9-4c2 7 0 9 0 9q3 3 3 9c0 11-7 14-14 15c1 1 2 3 2 6v8c0 1 0 2 2 2c3 0 22-9 22-30C64 14 50 0 32 0" />
                                  </svg>''',
                            height: 23,
                            width: 23,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 256 256">
                                <defs>
                                  <linearGradient id="logosTelegram0" x1="50%" x2="50%" y1="0%" y2="100%">
                                    <stop offset="0%" stop-color="#2aabee" />
                                    <stop offset="100%" stop-color="#229ed9" />
                                  </linearGradient>
                                </defs>
                                <path fill="url(#logosTelegram0)" d="M128 0C94.06 0 61.48 13.494 37.5 37.49A128.04 128.04 0 0 0 0 128c0 33.934 13.5 66.514 37.5 90.51C61.48 242.506 94.06 256 128 256s66.52-13.494 90.5-37.49c24-23.996 37.5-56.576 37.5-90.51s-13.5-66.514-37.5-90.51C194.52 13.494 161.94 0 128 0" />
                                <path fill="#fff" d="M57.94 126.648q55.98-24.384 74.64-32.152c35.56-14.786 42.94-17.354 47.76-17.441c1.06-.017 3.42.245 4.96 1.49c1.28 1.05 1.64 2.47 1.82 3.467c.16.996.38 3.266.2 5.038c-1.92 20.24-10.26 69.356-14.5 92.026c-1.78 9.592-5.32 12.808-8.74 13.122c-7.44.684-13.08-4.912-20.28-9.63c-11.26-7.386-17.62-11.982-28.56-19.188c-12.64-8.328-4.44-12.906 2.76-20.386c1.88-1.958 34.64-31.748 35.26-34.45c.08-.338.16-1.598-.6-2.262c-.74-.666-1.84-.438-2.64-.258c-1.14.256-19.12 12.152-54 35.686c-5.1 3.508-9.72 5.218-13.88 5.128c-4.56-.098-13.36-2.584-19.9-4.708c-8-2.606-14.38-3.984-13.82-8.41c.28-2.304 3.46-4.662 9.52-7.072" />
                              </svg>''',
                            height: 23,
                            width: 23,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PURPOSES OF ISTAD LMS',
                    style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.secondaryColor,fontSize: 15),
                  ),
                  Text('ISTAD LMS ',
                    style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.primaryColor,fontSize: 18),
                  ),
                  Text('LEARNING MANAGEMENT SYSTEM',
                    style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.primaryColor,fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Column(
                children: [
                  Lottie.asset(
                    'assets/animation/Animation5.json',
                    width: 400,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ISTAD LMS',
                    style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.primaryColor,fontSize: 17),
                  ),
                  SizedBox(height: 10,),
                  Text('Empowering Cambodia is IT Leaders' ,
                    style: TextStyle(color: AppColors.defaultGrayColor),
                  ),
                  SizedBox(height: 20,),
                  Text('Our Integrated School Management System is designed to streamline academic processes, making it effortless for both students and teachers to navigate daily school activities. This comprehensive system includes features such as attendance tracking, grade management, assignment submission, and communication tools.',
                      style: TextStyle(color: AppColors.defaultGrayColor)
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Column(
                children: [
                  Lottie.asset(
                    'assets/animation/Our_team3.json',
                    width: 400,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ISTAD LMS',
                    style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.primaryColor,fontSize: 17),
                  ),
                  SizedBox(height: 20,),
                  Text('It aims to enhance educational outcomes by providing a user-friendly interface that promotes collaboration and efficiency. Whether accessing course materials, submitting assignments, or communicating with peers and educators, our system ensures a seamless educational experience tailored to the needs of modern schools.',
                      style: TextStyle(color: AppColors.defaultGrayColor)
                  ),
                ],
              ),
              const SizedBox(height: 20,),
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
                      Row(
                        children: [
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1em" viewBox="0 0 576 512">
                                    <path fill="currentColor" d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19M288 400a144 144 0 1 1 144-144a143.93 143.93 0 0 1-144 144m0-240a95.3 95.3 0 0 0-25.31 3.79a47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160" />
                                  </svg>''',
                            height: 30,
                            width: 30,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Vision',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        'To become the leading IT institute in Cambodia, empowering individuals with cutting-edge technological skills, fostering innovation, and contributing to the digital transformation of the nation.',
                        style: TextStyle(fontSize: 14, color: AppColors.defaultGrayColor),
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
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
                      Row(
                        children: [
                          SvgPicture.string(
                            '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 16 16">
                                <path fill="currentColor" d="m13.637 2.363l1.676.335c.09.018.164.084.19.173a.25.25 0 0 1-.062.249l-1.373 1.374a.88.88 0 0 1-.619.256H12.31L9.45 7.611A1.5 1.5 0 1 1 6.5 8a1.5 1.5 0 0 1 1.889-1.449l2.861-2.862V2.552c0-.232.092-.455.256-.619L12.88.559a.25.25 0 0 1 .249-.062c.089.026.155.1.173.19Z" />
                                <path fill="currentColor" d="M2 8a6 6 0 1 0 11.769-1.656a.751.751 0 1 1 1.442-.413a7.502 7.502 0 0 1-12.513 7.371A7.501 7.501 0 0 1 10.069.789a.75.75 0 0 1-.413 1.442A6 6 0 0 0 2 8" />
                                <path fill="currentColor" d="M5 8a3.002 3.002 0 0 0 4.699 2.476a3 3 0 0 0 1.28-2.827a.748.748 0 0 1 1.045-.782a.75.75 0 0 1 .445.61A4.5 4.5 0 1 1 8.516 3.53a.75.75 0 1 1-.17 1.49A3 3 0 0 0 5 8" />
                              </svg>''',
                            height: 30,
                            width: 30,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Mission',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('•  Provide the latest methodology with high quality training and mentoring',
                            style: TextStyle(fontSize: 14, color: AppColors.defaultGrayColor),
                          ),
                          Text('•  Build up the capacity and career of IT experts in Cambodia',
                            style: TextStyle(fontSize: 14, color: AppColors.defaultGrayColor),
                          ),
                          Text('•  Consult and connect ISTAD trainees to top IT careers',
                            style: TextStyle(fontSize: 14, color: AppColors.defaultGrayColor),
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