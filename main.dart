import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(VideoApp());

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
  var daysTillChristmas;
  var adventNumber = 0;
  bool isDecember = false;

  @override
  void initState() {
    super.initState();
    getCurrentDate();
    _controller = VideoPlayerController.asset('assets/advent$adventNumber.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(
        children: [
          Center(child: VideoPlayer(_controller)),
          Padding(
            padding: const EdgeInsets.only(bottom: 300.0),
            child: Center(
              child: Image.asset(
                'assets/calendar.png',
                height: 350,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 330.0),
            child: Center(
                child: RotationTransition(
              turns: AlwaysStoppedAnimation(-1 / 360),
              child: Text(isDecember ? daysTillChristmas.toString() : '∞',
                  style: TextStyle(fontSize: 200, letterSpacing: -20)),
            )),
          ),
        ],
      )),
    );
  }

  void getCurrentDate() {
    var todayDay = new DateFormat.d().format(new DateTime.now());
    var todayMonth = new DateFormat.MMMM().format(new DateTime.now());
    var christmasDay = 24;
    daysTillChristmas = christmasDay - int.parse(todayDay);

    if (todayMonth == 'November') {
      if (int.parse(todayDay) >= 29) {
        adventNumber = 1;
      }
    }

    if (todayMonth == 'December') {
      isDecember = true;
      if (int.parse(todayDay) >= 6 && int.parse(todayDay) < 13) {
        adventNumber = 2;
      } else if (int.parse(todayDay) >= 13 && int.parse(todayDay) < 20) {
        adventNumber = 3;
      } else if (int.parse(todayDay) >= 20) {
        adventNumber = 4;
      }
    }
  }
}
