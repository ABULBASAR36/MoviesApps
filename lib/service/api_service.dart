
import 'package:moviesapps/model/video_model.dart';
import 'package:moviesapps/model/tv_model.dart';
import 'package:moviesapps/model/movie_model.dart';

import '../constants/constants.dart';
import '../model/cast_model.dart';
import 'dart:convert';
import 'package:http/http.dart';

enum MovieType { nowPlaying, popular, topRated, upcoming, similar }

enum TvType { popular, topRated, onTheAir, airingTody, similar }

enum ProgramType { tv, movie }

class ApiService {
  Future<List<MovieModel>> getMovieData(MovieType type,
      {int movieID = 0}) async {
    String url = "";
    if (type == MovieType.popular) {
      url = kmoviedbURL + kpopular;
    } else if (type == MovieType.topRated) {
      url = kmoviedbURL + ktop_rated;
    } else if (type == MovieType.upcoming) {
      url = kmoviedbURL + kupcoming;
    } else if (type == MovieType.nowPlaying) {
      url = kmoviedbURL + knowPlaying;
    } else if (type == MovieType.similar) {
      url = kmoviedbURL + movieID.toString() + ksimilar;
    }
    try {
      Response response = await get(Uri.parse(
          "$url?api_key=24517019cfd2eaeb475eb2cfcd62d234&language=en-US"));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['results'];
        List<MovieModel> movie =
            body.map((dynamic item) => MovieModel.fromJson(item)).toList();
        return movie;
      } else {
        throw ("No movie found");
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<List<CastModel>> getCastlist(int id, ProgramType type) async {
    String url = "";
    if (type == ProgramType.movie) {
      url = kmoviedbURL + id.toString() + kcredits;
    } else {
      url = ktvdbURL + id.toString() + kcredits;
    }
    try {
      Response response = await get(Uri.parse(
          "$url?api_key=24517019cfd2eaeb475eb2cfcd62d234&language=en-US"));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['cast'];
        List<CastModel> cast =
            body.map((dynamic item) => CastModel.fromJson(item)).toList();
        return cast;
      } else {
        throw ("No cast found");
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<List<VideoModel>> getVideo(int id, ProgramType type) async {
    String url = "";
    if (type == ProgramType.movie) {
      url = kmoviedbURL + id.toString() + kvideos;
    } else {
      url = ktvdbURL + id.toString() + kvideos;
    }
    try {
      Response response = await get(Uri.parse(
          "$url?api_key=24517019cfd2eaeb475eb2cfcd62d234&language=en-US"));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['results'];
        List<VideoModel> videos =
            body.map((dynamic item) => VideoModel.fromJson(item)).toList();
        return videos;
      } else {
        throw ("No cast found");
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<List<TvModel>> getTVData(TvType type, {int tvID = 0}) async {
    String url = "";
    if (type == TvType.popular) {
      url = ktvdbURL + kpopular;
    } else if (type == TvType.topRated) {
      url = ktvdbURL + ktop_rated;
    } else if (type == TvType.onTheAir) {
      url = ktvdbURL + kon_the_air;
    } else if (type == TvType.airingTody) {
      url = ktvdbURL + kairringToday;
    } else if (type == TvType.similar) {
      url = ktvdbURL + tvID.toString() + ksimilar;
    }

    try {
      Response response = await get(Uri.parse(
          "$url?api_key=24517019cfd2eaeb475eb2cfcd62d234&language=en-US"));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['results'];
        List<TvModel> tv =
            body.map((dynamic item) => TvModel.fromJson(item)).toList();
        return tv;
      } else {
        throw ("No tv found");
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}