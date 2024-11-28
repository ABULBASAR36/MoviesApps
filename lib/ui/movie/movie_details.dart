import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviesapps/componants/cast_page.dart' as cast_page;
import 'package:moviesapps/constants/constants.dart';
import 'package:moviesapps/model/movie_model.dart';
import 'package:moviesapps/model/video_model.dart';
import 'package:moviesapps/service/api_service.dart' as api_service;
import 'package:moviesapps/service/api_service.dart';
import 'package:moviesapps/ui/movie/movie_category.dart';
import 'package:url_launcher/url_launcher.dart';

enum ProgramType { movie, tv }

class MovieDetails extends StatelessWidget {
  final MovieModel movieModel;

  const MovieDetails({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    api_service.ApiService apiService = api_service.ApiService();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(movieModel.title ?? 'Unknown Movie'),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 240,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageUrl: kmoviedbImageurl + movieModel.backdropPath.toString(),
                    ),
                  ),
                  // Fetch video data (YouTube trailer)
                  FutureBuilder<List<VideoModel>>(
                    future: apiService.getVideos(movieModel.id ?? 0, ProgramType.movie as api_service.ProgramType),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Loading state
                      }
                      if (snapshot.hasError) {
                        return Icon(Icons.error, color: Colors.red); // Error state
                      }
                      if (snapshot.hasData) {
                        List<VideoModel> videos = snapshot.data ?? [];
                        print("Fetched videos: ${videos.length}"); // Debug: Check the number of videos fetched

                        if (videos.isNotEmpty) {
                          String videoKey = videos[0].key ?? '';
                          print("Video Key: $videoKey"); // Debug: Check the video key
                          
                          // Show the play button if a valid video key is available
                          return CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 35,
                            child: IconButton(
                              icon: Icon(Icons.play_circle, color: Colors.white),
                              onPressed: () async {
                                if (videoKey.isNotEmpty) {
                                  final videoUrl = 'https://www.youtube.com/watch?v=$videoKey'; // Correct URL format
                                  // Launch the video URL
                                  if (!await launchUrl(Uri.parse(videoUrl))) {
                                    throw Exception("Could not launch video");
                                  }
                                }
                              },
                            ),
                          );
                        }
                      }
                      return SizedBox(); // If no videos, return an empty widget
                    },
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                movieModel.title ?? 'Unknown Movie',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20),
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: movieModel.voteAverage ?? 0,
                    itemBuilder: (context, index) {
                      return Icon(Icons.star, color: Colors.amber);
                    },
                    itemCount: 5,
                    itemSize: 15,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: 5),
                  Text(
                    movieModel.voteAverage?.toStringAsFixed(1) ?? '0.0',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    "Released: ${movieModel.releaseDate ?? 'Unknown'}",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                movieModel.overview ?? 'No overview available',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                "Cast",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              cast_page.CastPage(id: movieModel.id ?? 0, type: cast_page.ProgramType.movie),
              SizedBox(height: 8),
              Text(
                "Similar Movies",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: MovieCategory(
                  movieType: MovieType.similar,
                  movieId: movieModel.id ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}