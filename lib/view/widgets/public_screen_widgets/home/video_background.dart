import 'package:flutter/material.dart';
import 'package:lms_mobile/view/screen/homeScreen/activities_and_event/activities_and_event_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

class VideoBackground extends StatefulWidget {
  const VideoBackground({super.key});

  @override
  State<VideoBackground> createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://static.vecteezy.com/system/browse_category/video/140/Cityscapes.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      }).catchError((error) {
        debugPrint("Error initializing video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video Background
        SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: _controller.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        // Overlay Content
        SafeArea(
          child: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 0),
                  child: Text(
                    'Institute of Science and\nTechnology Advanced\nDevelopment',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Button
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint("Navigate to Activity and Event");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ActivityAndEventPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'Activity and Event',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
