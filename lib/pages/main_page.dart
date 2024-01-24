// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1_restapi/model/movie_list.dart';
import 'package:flutter_application_1_restapi/pages/camera_pages.dart';
import 'package:flutter_application_1_restapi/pages/list_item.dart';
import 'package:flutter_application_1_restapi/pages/vidio_page.dart';

import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  var screenIndex = 0.obs;
  final List<Widget> screens = [
    MovieList(),
    ListItem(),
    TakePicture(),
    TakeVideo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: screens[screenIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromRGBO(17, 17, 17, 1),
            selectedItemColor: Color.fromRGBO(245, 197, 24, 1),
            unselectedItemColor: Color.fromRGBO(103, 104, 109, 1),
            selectedFontSize: 12,
            currentIndex: screenIndex.value,
            onTap: (value) => {screenIndex.value = value},
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt), label: 'List'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.camera_sharp), label: 'Camera'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_collection_outlined), label: 'Video'),
            ],
          ),
        ));
  }
}
