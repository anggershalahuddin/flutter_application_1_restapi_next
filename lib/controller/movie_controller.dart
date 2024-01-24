import 'dart:convert';
// import 'dart:html';

import 'package:flutter_application_1_restapi/model/movie.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MovieController extends GetxController {
  final url = "http://10.0.2.2:3000";
  // final url = "http://10.168.167.148:3000";
  var isLoading = false.obs;
  List<Movie> movies = <Movie>[].obs;
  late Movie movie;

  @override
  void onInit() {
    super.onInit();
    getMovies(1);
  }

  createHeaders() async {
    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('access_token');
    return {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
  }

  refreshMovie() async {
    movies.clear();
    await getMovies(1);
  }

  createMovie() {
    movie =
        Movie(id: 0, title: '', year: '', rating: 0, thumbnail: '', images: '');
  }

  getMovies(int page) async {
    isLoading(true);
    final headers = await createHeaders();
    final response = await http
        .get(Uri.parse('$url/movies?page=$page&perpage=100'), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      var list =
          List<Movie>.from(data['data'].map((item) => Movie.fromMap(item)));
      movies.addAll(list);
    }
    isLoading(false);
  }

  getMovie(int id) async {
    final headers = await createHeaders();
    final response =
        await http.get(Uri.parse('$url/movies/$id'), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data);
      movie = Movie.fromMap(data);
    }
  }

  insertMovie() async {
    isLoading(true);
    final headers = await createHeaders();
    final response = await http.post(Uri.parse('$url/movies'),
        headers: headers, body: jsonEncode(movie.toMap()));
    if (response.statusCode == 200) {
      return true;
    }
    isLoading(false);
    return false;
  }

  updateMovie(int id) async {
    isLoading(true);
    final headers = await createHeaders();
    final response = await http.put(Uri.parse('$url/movies/$id'),
        headers: headers, body: jsonEncode(movie.toMap()));
    if (response.statusCode == 200) {
      return true;
    }
    isLoading(false);
    return false;
  }

  deleteMovie(int id) async {
    final headers = await createHeaders();
    final response =
        await http.delete(Uri.parse('$url/movies/$id'), headers: headers);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
