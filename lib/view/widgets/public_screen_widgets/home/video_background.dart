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
        'https://rr2---sn-npoxu-2ois.googlevideo.com/videoplayback?expire=1735658028&ei=zLVzZ66cL8-M1d8Pk77m6QY&ip=136.228.158.126&id=o-ACoJiCoMbKfwmYgCb98bwrwsAyeX8sHYjGsNGG2xgM38&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1735636428%2C&mh=JD&mm=31%2C29&mn=sn-npoxu-2ois%2Csn-npoldn7d&ms=au%2Crdu&mv=m&mvi=2&pl=24&rms=au%2Cau&initcwndbps=1276250&bui=AfMhrI9b5cpsS_ipVMA5VbGblzqHh6ieGgXU2yokg-pDD7ldjy26tpOIx8ifsbi_p_XJBIH1kcb4f9Yd&vprv=1&svpuc=1&mime=video%2Fmp4&ns=3MTYG5dubCesvHCD3FbMMkcQ&rqh=1&gir=yes&clen=1704251&ratebypass=yes&dur=30.696&lmt=1730387521026597&mt=1735635928&fvip=3&fexp=51326932%2C51331020%2C51335594%2C51371294&c=MWEB&sefc=1&txp=5309224&n=3iv4bi6qzZNH4w&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRQIhAJJK_wDQD0tZuKzBfu9OugVuCuJkiEqktWTwm4OvUhamAiAxE2UXJo67CMPkuLct2qBdVdc8VWUXXZjdwlfuS5krUQ%3D%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=AGluJ3MwRgIhAOhw0AcSxhbYvZvOHTdCCMWKvBW2oTRQU8xigvU0e2BbAiEAsREJlMk_BOJX3duqwX9Ve37FGo9k98zPX7tSrvw4J6Q%3D')
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
