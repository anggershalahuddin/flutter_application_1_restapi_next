// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class TakePicture extends StatelessWidget {
  TakePicture({super.key});

  var imagePath = ''.obs;

  openCamera() async {
    final imageFile = await ImagePicker().pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (imageFile == null) {
      imagePath('');
    } else {
      imagePath(imageFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(36, 42, 50, 1),
        appBar: AppBar(
          title: Text('Take Your Photo'),
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
                        child: imagePath.value == ''
                            ? Image.asset('assets/images/no-camera.png')
                            : Image.file(File(imagePath.value))),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
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
                                'Take Picture',
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
