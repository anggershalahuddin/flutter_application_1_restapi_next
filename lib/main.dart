// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1_restapi/controller/movie_controller.dart';
import 'package:flutter_application_1_restapi/model/login.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  MovieController controller = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter RestAPI',
        debugShowCheckedModeBanner: false,
        home: LoginPage());
  }
}
