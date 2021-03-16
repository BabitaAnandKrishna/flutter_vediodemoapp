// // import 'package:video_player/video_player.dart';
// // import 'package:flutter/material.dart';
// //
// // class VideoDemo extends StatefulWidget {
// //   VideoDemo() : super();
// //   final String title = "Video Demo";
// //
// //   @override
// //   _VideoDemoState createState() => _VideoDemoState();
// // }
// //
// // class _VideoDemoState extends State<VideoDemo> {
// //   VideoPlayerController _controller;
// //   Future<void> _initializeVideoPlayerFuture;
// //
// //   @override
// //   void initstate() {
// //     // _controller = VideoPlayerController.network(
// //     //     "http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4");
// //
// //     _controller = VideoPlayerController.network(
// //         "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
// //     //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
// //     _initializeVideoPlayerFuture = _controller.initialize();
// //     _controller.setVolume(1.0);
// //     _controller.setLooping(true);
// //     super.initState();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Video Demo"),
// //       ),
// //       body: FutureBuilder(
// //         future: _initializeVideoPlayerFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.done) {
// //             return Center(
// //               child: AspectRatio(
// //                 aspectRatio: _controller.value.aspectRatio,
// //                 child: VideoPlayer(_controller),
// //               ),
// //             );
// //           }
// //           else{
// //             return Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: (){
// //           setState(() {
// //             if(_controller.value.isPlaying){
// //               _controller.pause();
// //             }else {
// //               _controller.play();
// //             }
// //           });
// //         },
// //         child: Icon(_controller.value.isPlaying ?
// //         Icons.pause : Icons.play_arrow ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';
//
// void main() => runApp(VideoApp());
//
// class VideoApp extends StatefulWidget {
//
//   @override
//   _VideoAppState createState() => _VideoAppState();
// }
//
// class _VideoAppState extends State<VideoApp> {
//   VideoPlayerController _controller;
//   Future<void> _initializeVideoPlayerFuture;
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//         // 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
//         "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
//     _initializeVideoPlayerFuture = _controller.initialize();
//     super.initState();
//     // ..initialize().then((_) {
//     //     setState(() {});
//       // }
//       // );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Demo',
//       home: Scaffold(
//         body: Center(
//           child: _controller.value.initialized
//               ? AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           )
//               : Container(),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               if (_controller.value.isPlaying) {
//                 _controller.pause();
//               } else {
//                 // If the video is paused, play it.
//                 _controller.play();
//               }
//             });
//           },
//           child: Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        // "http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}