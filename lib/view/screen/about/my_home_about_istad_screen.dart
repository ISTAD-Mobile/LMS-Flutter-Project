import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lms_mobile/data/color/color_screen.dart';
import 'package:lms_mobile/view/screen/register/register_step_1.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeIstadScreen extends StatefulWidget {
  const HomeIstadScreen({super.key});

  @override
  State<HomeIstadScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeIstadScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
              child: Column(
                children: [
                  _buildFeatureCard(
                    'Vision',
                    'Advanced IT Institute in Cambodia',
                    'Learn More',
                    'assets/images/about_istad_img.png',
                    false,
                    titleColor: Colors.white,
                    subtitleColor: Colors.white,
                    buttonColor: AppColors.primaryColor99,
                    buttonTextColor: Colors.white,
                    cardHeight: 170,
                    borderRadius: 10.0,
                    onButtonPressed: () async {
                      const facebookUrl = 'https://www.facebook.com/istad.co?mibextid=ZbWKwL';
                      if (await canLaunch(facebookUrl)) {
                        await launch(facebookUrl);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(
                              'Could not open Facebook')),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureCard(
                    'Mission',
                    'Provide the latest methodology with high-quality',
                    'Get Started',
                    'assets/images/about_istad_img1.png',
                    true, // Reversed
                    titleColor: Colors.white,
                    subtitleColor: Colors.white,
                    buttonColor: AppColors.secondaryColor,
                    buttonTextColor: Colors.white,
                    cardHeight: 170,
                    fontSize: 22.0,
                    borderRadius: 10.0,
                    onButtonPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterStep1()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureCard(
                    'Institute of Science and Technology Advanced Development',
                    '',
                    'Enroll Now',
                    'assets/images/about_istad_img2.png',
                    false, // Not reversed
                    titleColor: Colors.white,
                    buttonColor: AppColors.primaryColor99,
                    buttonTextColor: Colors.white,
                    borderRadius: 10.0,
                    cardHeight: 180,
                    onButtonPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterStep1()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // About Us Section
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ABOUT US',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'INSTITUTE OF SCIENCE AND TECHNOLOGY ADVANCED DEVELOPMENT ?',
                    style: TextStyle(
                      color: AppColors.primaryColor99,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ruler
                        Container(
                          width: 5,
                          height: 55,
                          color: AppColors.secondaryColor,
                          margin: const EdgeInsets.only(top: 30),
                        ),
                        const SizedBox(width: 8),
                        // Text Column
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("WHY SHOULD YOU CHOOSE US ?", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),),
                            Text("ISTAD", style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w600)),
                            Text("Institute", style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  _buildInfoSection('WHO ARE WE?',
                      'INSTITUTE is a noteworthy science and technology institute in Cambodia. INSTITUTE has routed Cambodian students to advanced science and technology, research, and develop digital skills and our graduates have been guaranteed excellent job opportunities with the Top IT company.'
                  ),
                  _buildInfoSection('VISION & MISSION', ''),
                  _buildInfoContent(
                      'OUR VISION', 'Advanced IT Institute in Cambodia'),
                  _buildInfoContentMission('OUR MISSION', ''),
                  _buildMissionList('OUR MISSION', ''),
                  _buildContactSection(),
                  SizedBox(height: 20,),
                  const Center(
                    child: MapWidget(
                      center: LatLng(11.578277484937441, 104.90179990955635),
                      markerTitle: 'Science and Technology Advanced Development Co., Ltd.',
                      markerSnippet:
                      'No. 24, St. 562, Sangkat Boeung Kak I, Khan Toul Kork, Phnom Penh, Cambodia',
                      mapHeight: 200.0,
                      mapWidth: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String title,
      String subtitle,
      String buttonText,
      String backgroundImage,
      bool isReversed, {
        Color titleColor = Colors.white,
        Color subtitleColor = Colors.white70,
        Color buttonColor = Colors.red,
        Color buttonTextColor = Colors.white,
        double borderRadius = 10.0,
        double cardHeight = 180.0,
        double fontSize = 20.0,
        required VoidCallback onButtonPressed,
      }) {
    return Container(
      width: double.infinity,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          // Positioned image with blur effect
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Image.asset(
                backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment:
              isReversed ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 16,
                    ),
                  ),
                Container(
                  alignment:
                  isReversed ? Alignment.centerLeft : Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: buttonTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildInfoContent(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              const Icon(Icons.diamond, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        if (content.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 32, top: 8, bottom: 16),
            child: Text(content),
          ),
      ],
    );
  }

  Widget _buildInfoContentMission(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              const Icon(Icons.diamond, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        if (content.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 32, top: 8, bottom: 16),
            child: Text(content),
          ),
      ],
    );
  }


  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.string(
              '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 1200 1200">
                  <path fill="currentColor" d="M600 0C268.629 0 0 268.629 0 600s268.629 600 600 600s600-268.629 600-600S931.371 0 600 0m3.955 209.912l94.556 295.239l309.889 6.958l-251.588 181.055l89.136 296.924l-249.976-183.325l-254.81 176.587l97.119-294.434l-246.68-187.793l310.034 1.392z" />
                </svg>''',
              height: 23,
              width: 23,
              color: AppColors.accentColor,
            ),
            // const Icon(Icons.diamond, color: AppColors.primaryColor99),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        if (content.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 32, top: 8, bottom: 16),
            child: Text(content),
          ),
      ],
    );
  }

  Widget _buildMissionList(String title, String content) {
    return const Padding(
      padding: EdgeInsets.only(left: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '• Provide the latest methodology with high-quality training and mentoring'),
          Text('• Build up the capacity and career of IT experts in Cambodia'),
          Text('• Consult and connect ISTAD trainees to top IT careers'),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      // Add top margin to the entire contact section
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'If you have any questions, please feel free to contact us.',
            style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.primaryColor99),
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            Icon(Icons.location_on, size: 28, color: AppColors.primaryColor99),
            'No. 12, St. 323, Sangkat Boeung Kak II, Khan Toul Kork, Phnom Penh, Cambodia',
          ),
          _buildContactItem(
            Icon(Icons.facebook, size: 28, color: AppColors.primaryColor99),
            'Facebook',
          ),
          _buildContactItem(
            Icon(Icons.telegram, size: 28, color: AppColors.primaryColor99),
            'Telegram',
          ),
          _buildContactItem(
            Icon(Icons.email, size: 28, color: AppColors.primaryColor99),
            'info.istad@gmail.com',
          ),
          _buildContactItem(
            Icon(Icons.video_collection, size: 28,
                color: AppColors.primaryColor99),
            'YouTube',
          ),
          _buildContactItem(
            Icon(Icons.phone, size: 28, color: AppColors.primaryColor99),
            '(+855) 95 990 910 | (+855) 93 990 910',
          ),
          _buildContactItem(
            Image.network(
              'https://cdn-icons-png.flaticon.com/256/7192/7192499.png',
              width: 24,
              height: 24,
                color: AppColors.primaryColor99
            ),
            ' www.istad.edu.kh',
          ),
        ],
      ),
    );
  }


  Widget _buildContactItem(Widget icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.primaryColor99,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MapWidget extends StatefulWidget {
  final LatLng center;
  final String markerTitle;
  final String markerSnippet;
  final double mapHeight;
  final double mapWidth;

  const MapWidget({
    Key? key,
    required this.center,
    required this.markerTitle,
    required this.markerSnippet,
    this.mapHeight = 200.0,
    this.mapWidth = double.infinity,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initializeMarker();
  }

  void _initializeMarker() {
    _markers.add(
      Marker(
        markerId: const MarkerId('location'),
        position: widget.center,
        infoWindow: InfoWindow(
          title: widget.markerTitle,
          snippet: widget.markerSnippet,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.mapWidth,
      height: widget.mapHeight,
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey.shade400),
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: widget.center,
            zoom: 17.0,
          ),
          markers: _markers,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
