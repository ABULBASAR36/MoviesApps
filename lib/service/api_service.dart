import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:moviesapps/componants/cast_list_item.dart';
import 'package:moviesapps/constants/constants.dart';
import 'package:moviesapps/model/movie_model.dart';
import 'package:moviesapps/model/tv_model.dart';
import 'package:moviesapps/model/video_model.dart';
//import 'package:moviesapps/model/cast_model.dart'; // Make sure you have the CastModel import

enum MovieType { nowPlaying, popular, topRated, upcoming, similar }
enum TvType { airing_today, on_the_air, popular, top_rated, similar }
enum ProgramType { tv, movie }

class ApiService {
  // Define your API key
  final String apiKey = '24517019cfd2eaeb475eb2cfcd62d234';  // Replace with your actual API key

  // Movie API calls
  Future<List<MovieModel>> getMovieData(MovieType type, {int movieID = 0}) async {
    String url = "";

    // Construct the URL based on the type of movie request
    if (type == MovieType.nowPlaying) {
      url = kmovieDbURL + know_playing;
    } else if (type == MovieType.popular) {
      url = kmovieDbURL + kpopular;
    } else if (type == MovieType.topRated) {
      url = kmovieDbURL + ktop_rated;
    } else if (type == MovieType.upcoming) {
      url = kmovieDbURL + kupcoming;
    } else if (type == MovieType.similar && movieID != 0) {
      url = kmovieDbURL + movieID.toString() + ksimilar;
    }

    try {
      Response response = await get(Uri.parse(
          url + "?api_key=$apiKey&language=en-US"));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['results'];
        List<MovieModel> movielist =
            body.map((item) => MovieModel.fromJson(item)).toList();

        return movielist;
      } else {
        throw Exception("No movie found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // TV API calls
  Future<List<TvModel>> getTvData(TvType type, {int tvId = 0}) async {
    String url = "";

    // Construct the URL based on the type of TV request
    if (type == TvType.popular) {
      url = ktvDbURL + kpopular;
    } else if (type == TvType.top_rated) {
      url = ktvDbURL + ktop_rated;
    } else if (type == TvType.on_the_air) {
      url = ktvDbURL + kon_the_air;
    } else if (type == TvType.airing_today) {
      url = ktvDbURL + kairing_today;
    } else if (type == TvType.similar && tvId != 0) {
      url = ktvDbURL + tvId.toString() + ksimilar;
    }

    try {
      Response response = await get(Uri.parse(
          url + "?api_key=$apiKey&language=en-US"));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['results'];
        List<TvModel> tvprogramlist =
            body.map((item) => TvModel.fromJson(item)).toList();

        return tvprogramlist;
      } else {
        throw Exception("No TV found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get videos for either TV shows or movies
  Future<List<VideoModel>> getVideos(int id, ProgramType type) async {
    String url = "";

    if (type == ProgramType.movie) {
      url = kmovieDbURL + id.toString() + kvideos;
    } else if (type == ProgramType.tv) {
      url = ktvDbURL + id.toString() + kvideos;
    }

    try {
      Response response = await get(Uri.parse(
          url + "?api_key=$apiKey&language=en-US"));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['results'];
        List<VideoModel> videoslist =
            body.map((item) => VideoModel.fromJson(item)).toList();

        return videoslist;
      } else {
        throw Exception("No videos found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get cast list for either TV shows or movies
  Future<List<CastModel>> getCastList(int id, ProgramType type) async {
    String url = "";

    if (type == ProgramType.movie) {
      url = kmovieDbURL + id.toString() + kcredits;
    } else if (type == ProgramType.tv) {
      url = ktvDbURL + id.toString() + kcredits;
    }

    try {
      Response response = await get(Uri.parse(
          url + "?api_key=$apiKey&language=en-US"));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['cast'];
        List<CastModel> castlist =
            body.map((item) => CastModel.fromJson(item)).toList();

        return castlist;
      } else {
        throw Exception("No cast found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}