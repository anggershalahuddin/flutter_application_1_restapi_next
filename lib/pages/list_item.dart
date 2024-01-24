// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1_restapi/controller/auth_controller.dart';
import 'package:flutter_application_1_restapi/controller/movie_controller.dart';
import 'package:flutter_application_1_restapi/model/login.dart';
import 'package:flutter_application_1_restapi/model/movie_detail.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItem extends StatelessWidget {
  ListItem({super.key});
  MovieController controller = Get.put(MovieController());
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(36, 42, 50, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(36, 42, 50, 1),
          title: Text(
            'Movie List',
          ),
          actions: [
            IconButton(
                onPressed: () {
                  authController.logout();
                  Get.off(LoginPage());
                },
                icon: Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            controller.createMovie();
            Get.to(MovieDetail());
          },
          child: Icon(
            Icons.add,
            size: 35,
          ),
        ),
        body: Obx(
          () => Container(
            padding: EdgeInsets.all(15),
            // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.amber,
                  ))
                : ListView.builder(
                    itemCount: controller.movies.length,
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //     mainAxisSpacing: 10,
                    //     crossAxisSpacing: 10,
                    //     childAspectRatio: 0.47),
                    itemBuilder: (context, index) {
                      final movie = controller.movies[index];
                      return InkWell(
                        onTap: () async {
                          await controller.getMovie(movie.id);
                          Get.to(MovieDetail());
                        },
                        child: Container(
                          height: 120,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 3, 0, 60),
                              border: Border.all(
                                  color: Color.fromARGB(255, 3, 0, 60)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // height: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  child: Container(
                                    child: Image.network(
                                      movie.images,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      child: Text(movie.title,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      child: Text(movie.year,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 15,
                                          ),
                                        ),
                                        Text(
                                          '${movie.rating}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ));
  }
}
