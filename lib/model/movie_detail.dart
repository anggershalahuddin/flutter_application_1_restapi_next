// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1_restapi/controller/movie_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetail extends StatelessWidget {
  MovieDetail({super.key});

  MovieController controller = Get.find();
  final formKey = GlobalKey<FormState>();

  onSave() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final movie = controller.movie;
      var result = movie.id == 0
          ? await controller.insertMovie()
          : await controller.updateMovie(movie.id);
      if (result) {
        await controller.refreshMovie();
        Get.back();
      }
    }
  }

  // onSave() async {
  //   print('Ini berhasil');
  //   await controller.refreshMovie();
  //   Get.back();
  // }

  onDelete() async {
    final movie = controller.movie;
    var result = movie.id > 0;
    await controller.deleteMovie(movie.id);
    if (result) {
      await controller.refreshMovie();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = controller.movie;
    return Scaffold(
      backgroundColor: Color.fromRGBO(36, 42, 50, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 42, 50, 1),
        title: Text('Movie Detail'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            // padding: EdgeInsets.only(top: 10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Your Movie Here',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.yellow[600]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 75,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(166, 166, 166, 1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "ID",
                          hintStyle: TextStyle(color: Colors.black87)),
                      enabled: false,
                      initialValue: movie.id.toString(),
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Title",
                          hintStyle: TextStyle(color: Colors.black87)),
                      initialValue: movie.title,
                      style: TextStyle(color: Colors.black),
                      onSaved: (newValue) {
                        movie.title = newValue!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Year",
                          hintStyle: TextStyle(color: Colors.black87)),
                      initialValue: movie.year,
                      onSaved: (newValue) {
                        movie.year = newValue!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 85,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "ٌRating",
                          hintStyle: TextStyle(color: Colors.black87)),
                      initialValue: '${movie.rating}',
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        movie.rating = double.tryParse(newValue!)!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Thumbnail",
                          hintStyle: TextStyle(color: Colors.black87)),
                      initialValue: movie.thumbnail,
                      onSaved: (newValue) {
                        movie.thumbnail = newValue!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Images",
                          hintStyle: TextStyle(color: Colors.black87)),
                      initialValue: movie.images,
                      onSaved: (newValue) {
                        movie.images = newValue!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(245, 197, 24, 1)),
                        onPressed: () async {
                          await onSave();
                        },
                        child: Text(
                          'Save',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () async {
                          await onDelete();
                        },
                        child: Text('Delete',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600))),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
