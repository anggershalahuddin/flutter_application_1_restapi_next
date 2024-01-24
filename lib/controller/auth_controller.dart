import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final url = "http://10.0.2.2:3000";
  // final url = "http://10.168.167.148:3000";
  var isLoading = false.obs;
  var isLoggedin = false.obs;
  var message = "".obs;

  login(Map<String, dynamic> payload) async {
    isLoading(true);
    message("");

    final response = await http.post(Uri.parse('$url/login'),
        body: jsonEncode(payload),
        headers: {'Content-Type': "application/json"});
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final accessToken = data['access_token'];
      final pref = await SharedPreferences.getInstance();
      await pref.setString("access_token", accessToken);
      await pref.setString("user", jsonEncode(data['user']));
      isLoggedin(true);
    } else if (response.statusCode == 422) {
      final errors = data['errors'];
      final error = errors[0];
      message(error['msg']);
      isLoggedin(false);
    } else {
      message(data['message']);
      isLoggedin(false);
    }
    isLoading(false);
  }

  logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    isLoggedin(false);
  }
}
