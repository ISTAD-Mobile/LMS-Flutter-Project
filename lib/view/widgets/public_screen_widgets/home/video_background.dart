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
        // 'https://static.vecteezy.com/system/browse_category/video/140/Cityscapes.mp4')
      'https://rr2---sn-npoxu-2ois.googlevideo.com/videoplayback?expire=1739357029&ei=BSesZ-SbLtHUg8UPuqjkgQY&ip=136.228.158.126&id=o-AKHs_iTwgnvVnYwjnqNoie8lL8fOuoUIFUdsU878YBVB&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1739335429%2C&mh=JD&mm=31%2C29&mn=sn-npoxu-2ois%2Csn-npoe7nlz&ms=au%2Crdu&mv=m&mvi=2&pl=24&rms=au%2Cau&pcm2=yes&initcwndbps=1205000&bui=AUWDL3zGDgy3jfQgVksBDRasMTtm5s3_Gc5i2-p2Hez8qV3JPK59TRdwRfMKmX2uktNHhIrVmsxpj5cm&spc=RjZbSd4NzuCaxFm_2kzdZD7ofOePLYi5c21knnWhUmGOX-sLsouF0bBDwxrXWLAU_g&vprv=1&svpuc=1&mime=video%2Fmp4&ns=CRnDg4jcuiV_admMqTGNuXoQ&rqh=1&gir=yes&clen=1704251&ratebypass=yes&dur=30.696&lmt=1730387521026597&mt=1739335021&fvip=5&fexp=51326932%2C51331020&c=MWEB&sefc=1&txp=5309224&n=AnQINoy9v2EZ7w&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cpcm2%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRAIgIscLipWBctEKJr2IMl5ulZ2YL6Zv0RrNu8sCJnLk7Z8CIH3UqQ_XdigrOIZPRWMZXG1NuH_7UxXvEdsEVorsFzfu&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=AGluJ3MwRQIhAOF9RseNyJKCQMtr5b1Ex30rUGmUNELQlhjPgpYOppjbAiByv-KB6PVzYCKYtGEmpE4E4ZuiKWRNEupagTm34xpbqw%3D%3D')
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
