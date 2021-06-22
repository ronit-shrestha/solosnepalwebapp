import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoLaptop extends StatefulWidget {
  @override
  _VideoLaptopState createState() => _VideoLaptopState();
}

class _VideoLaptopState extends State<VideoLaptop> {
  VideoPlayerController _controller;
  Future<void> _initalizeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/solosdesk.mp4');

    _initalizeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
    _controller.setVolume(0);
    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        child: FutureBuilder(
          future: _initalizeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                // height: size.height * .9,
                child: VideoPlayer(_controller),
              );
              // AspectRatio(
              //   aspectRatio: size.width * 2,
              //   // _controller.value.aspectRatio,
              //   child: VideoPlayer(_controller),
              // );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
