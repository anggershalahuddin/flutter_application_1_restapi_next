// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class TakeVideo extends StatelessWidget {
  TakeVideo({super.key});

  var videoPath = ''.obs;

  var controller = VideoPlayerController.file(File(''));

  openCamera() async {
    final videoFile = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (videoFile == null) {
      videoPath('');
    } else {
      videoPath(videoFile.path);
      controller = VideoPlayerController.file(File(videoFile.path));
      controller.initialize();
      controller.setLooping(true);
      controller.play();
    }
  }

  playVideo() async {
    controller.play();
    // controller.setLooping(true);
  }

  pauseVideo() async {
    controller.pause();
  }

  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(36, 42, 50, 1),
        appBar: AppBar(
          title: Text('Take Your Video'),
        ),
        body: Obx(
          () => Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: 500,
                        child: videoPath.value == ''
                            ? Image.asset('assets/images/no-video.png')
                            : VideoPlayer(controller)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                fixedSize: Size(95, 50)),
                            onPressed: () async {
                              await pauseVideo();
                            },
                            child: Icon(Icons.pause)),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                fixedSize: Size(95, 50)),
                            onPressed: () async {
                              await playVideo();
                            },
                            child: Icon(Icons.play_arrow)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 200,
                          height: 60,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(245, 197, 24, 1)),
                              onPressed: () async {
                                await openCamera();
                              },
                              child: Text(
                                'Take Video',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
