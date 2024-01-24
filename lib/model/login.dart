// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1_restapi/controller/auth_controller.dart';
import 'package:flutter_application_1_restapi/pages/main_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final formKey = GlobalKey<FormState>();
  final formData = {"email": "", "password": ""};
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(36, 42, 50, 1),
      body: Obx(() => Center(
            child: Form(
              key: formKey,
              child: Container(
                height: 400,
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Container(
                        width: 100,
                        child: Image.asset('assets/images/logo_imdb.png')),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'SIgn In',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(245, 197, 24, 1)),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.email, color: Colors.black54),
                          hintText: 'Email',
                          hintStyle:
                              GoogleFonts.poppins(color: Colors.black87)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                      },
                      onSaved: (newValue) {
                        formData["email"] = newValue!;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.key, color: Colors.black54),
                          hintText: 'Password',
                          hintStyle:
                              GoogleFonts.poppins(color: Colors.black87)),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                      },
                      onSaved: (newValue) {
                        formData["password"] = newValue!;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 30,
                      child: Text(
                        controller.message.value,
                        style:
                            TextStyle(color: Color.fromRGBO(245, 197, 24, 1)),
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(245, 197, 24, 1)),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                await controller.login(formData);
                                if (controller.isLoggedin.value) {
                                  Get.off(MainPage());
                                }
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
