import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:moviesapps/componants/cast_page.dart';
import 'package:moviesapps/model/movie_model.dart';
import 'package:moviesapps/model/video_model.dart';
import 'package:moviesapps/ui/movie/movie_category.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../service/api_service.dart';


class MovieDetails extends StatelessWidget {
  final MovieModel movieModel;

  const MovieDetails({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(movieModel.title.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl:
                        kmoviedbImageURL + movieModel.backdropPath.toString(),
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<VideoModel> videos = snapshot.data ?? [];
                        if (videos.isNotEmpty) {
                          return CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.5),
                            child: IconButton(
                              icon: Icon(
                                Icons.play_circle,
                                color: Colors.redAccent,
                              ),
                              onPressed: () async {
                                if (videos.isNotEmpty) {
                                  if (!await launchUrl(Uri.parse(
                                      'https://www.youtube.com/embed/${videos[0].key}'))) {
                                    throw Exception(
                                        'Could not launch ${videos[0].key}');
                                  }
                                }
                              },
                            ),
                          );
                        }
                      }
                      return Container();
                    },
                    future: apiService.getVideo(
                        movieModel.id ?? 0, ProgramType.movie),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                movieModel.title.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 24,
                  background: Paint()
                    ..shader = LinearGradient(
                      colors: [Colors.red, Colors.purple, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(Rect.fromLTWH(0, 0, 200, 50)),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBarIndicator(
                    rating: movieModel.voteAverage ?? 0,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    movieModel.voteAverage == null
                        ? ""
                        : movieModel.voteAverage.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Released: ${movieModel.releaseDate}",
                style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                movieModel.overview.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Cast",
                style: TextStyle(color: Colors.white, fontSize: 20, background: Paint()
                  ..shader = LinearGradient(
                    colors: [Colors.green, Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(Rect.fromLTWH(0, 0, 200, 50)),
                ),
              ),
              SizedBox(
                height: 200,
                child: CastPage(
                  id: movieModel.id ?? 0,
                  type: ProgramType.movie,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Similar Movie",
                style: TextStyle(color: Colors.white, fontSize: 20, background: Paint()
                  ..shader = LinearGradient(
                    colors: [Colors.pink, Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(Rect.fromLTWH(0, 0, 200, 50)),
                ),
              ),
              SizedBox(
                height: 200,
                child: MoviesCategory(
                  movieType: MovieType.similar,
                  movieID: movieModel.id ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
