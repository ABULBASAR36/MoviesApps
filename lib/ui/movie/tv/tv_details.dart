import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:moviesapps/componants/cast_page.dart' as cast_page; // Aliased CastPage import
import 'package:moviesapps/constants/constants.dart';
//import 'package:moviesapps/constants/program_type.dart'; // Import shared ProgramType
import 'package:moviesapps/model/tv_model.dart';
import 'package:moviesapps/model/video_model.dart';
import 'package:moviesapps/service/api_service.dart' as api_service; // Aliased ApiService import
import 'package:moviesapps/service/api_service.dart';
import 'package:moviesapps/ui/movie/tv/tv_category.dart';
import 'package:url_launcher/url_launcher.dart';

class TvDetailsPage extends StatelessWidget {
  final TvModel tvModel;
  const TvDetailsPage({super.key, required this.tvModel});

  @override
  Widget build(BuildContext context) {
    api_service.ApiService api = api_service.ApiService(); // Using the aliased ApiService

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(tvModel.name ?? 'Unknown TV Show'),
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
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                      imageUrl: tvModel.backdropPath != null
                          ? kmoviedbImageurl + tvModel.backdropPath!
                          : 'https://via.placeholder.com/500', // Default placeholder
                    ),
                  ),
                  FutureBuilder<List<VideoModel>>(
                    future: api.getVideos(tvModel.id ?? 0, cast_page.ProgramType.tv as api_service.ProgramType), // Using the aliased ProgramType
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Icon(Icons.error, color: Colors.red);
                      }
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<VideoModel> videos = snapshot.data!;
                        return CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 35,
                          child: IconButton(
                            icon: Icon(Icons.play_circle, color: Colors.white, size: 35),
                            onPressed: () async {
                              final videoUrl = 'https://www.youtube.com/watch?v=${videos[0].key}';
                              if (!await launchUrl(Uri.parse(videoUrl))) {
                                throw Exception("Could not launch video URL");
                              }
                            },
                          ),
                        );
                      }
                      return SizedBox(); // Empty widget if no videos
                    },
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                tvModel.name ?? 'Unknown TV Show',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: (tvModel.voteAverage ?? 0.0) / 2,
                    itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    tvModel.voteAverage?.toStringAsFixed(1) ?? 'N/A',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    "Released: ${tvModel.firstAirDate ?? 'Unknown'}",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                tvModel.overview ?? 'No overview available.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Cast",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              cast_page.CastPage(id: tvModel.id ?? 0, type: cast_page.ProgramType.tv), // Using the aliased CastPage and ProgramType
              SizedBox(height: 20),
              Text(
                "Similar TV Programs",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: TvCategory(
                  tvType: TvType.similar,
                  tvid: tvModel.id ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
