import 'package:flutter/material.dart';

import 'package:moviesapps/service/api_service.dart';
import 'package:moviesapps/ui/movie/componants/movie_carousel.dart';
import 'package:moviesapps/ui/movie/movie_category.dart';

import '../../model/movie_model.dart';


class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MovieModel> moviemodel = snapshot.data ?? [];
                return MovieCarosel(movieModellist: moviemodel);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            future: apiService.getMovieData(MovieType.nowPlaying),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Popular Movie Section
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [Colors.orange, Colors.yellow, Colors.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                    },
                    child: Text(
                      "Popular Movie",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 200,
                    child: MoviesCategory(
                      movieType: MovieType.popular,
                    ),
                  ),
                  // Top Rated Movie Section
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [Colors.green, Colors.blue, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                    },
                    child: Text(
                      "Top Rated Movie",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 200,
                    child: MoviesCategory(
                      movieType: MovieType.topRated,
                    ),
                  ),
                  // Upcoming Movie Section
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [Colors.pink, Colors.purple, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                    },
                    child: Text(
                      "Upcoming Movie",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 200,
                    child: MoviesCategory(
                      movieType: MovieType.upcoming,
                    ),
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
