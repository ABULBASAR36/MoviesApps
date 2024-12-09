import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviesapps/componants/cast_page.dart';
import 'package:moviesapps/constants/constants.dart';
import 'package:moviesapps/model/tv_model.dart';
import 'package:moviesapps/model/video_model.dart';
import 'package:moviesapps/service/api_service.dart';
import 'package:moviesapps/ui/movie/tv/tv_category.dart';
import 'package:url_launcher/url_launcher.dart';

class TVDetails extends StatelessWidget {
  final TvModel tvModel;

  const TVDetails({super.key, required this.tvModel});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(tvModel.originalName.toString()),
        backgroundColor: Colors.black.withOpacity(0.8), // Darker AppBar background
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
                    imageUrl: kmoviedbImageURL + tvModel.posterPath.toString(),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<VideoModel> videos = snapshot.data ?? [];

                        if (videos.isNotEmpty) {
                          return CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.6),
                            child: IconButton(
                              icon: Icon(
                                Icons.play_circle,
                                color: Colors.white,
                                size: 40,
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
                    future: apiService.getVideo(tvModel.id ?? 0, ProgramType.tv),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                tvModel.originalName.toString(),
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
                children: [
                  RatingBarIndicator(
                    rating: tvModel.voteAverage ?? 0,
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
                    tvModel.voteAverage == null ? "" : tvModel.voteAverage.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    "Released: ${tvModel.firstAirDate}",
                    style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                tvModel.overview.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 16),
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
                  id: tvModel.id ?? 0,
                  type: ProgramType.tv,
                ),
              ),
              Text(
                "Similar TV",
                style: TextStyle(color: Colors.white, fontSize: 20, background: Paint()
                  ..shader = LinearGradient(
                    colors: [Colors.pink, Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(Rect.fromLTWH(0, 0, 200, 50)),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 200,
                child: TvCategory(
                  tvType: TvType.similar,
                  tvID: tvModel.id ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
