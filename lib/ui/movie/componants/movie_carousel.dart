import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:moviesapps/model/movie_model.dart';

import '../../../constants/constants.dart';
import '../movie_details.dart';

class MovieCarosel extends StatefulWidget {
  final List<MovieModel> movieModellist;

  const MovieCarosel({super.key, required this.movieModellist});

  @override
  State<MovieCarosel> createState() => _MovieCaroselState();
}

class _MovieCaroselState extends State<MovieCarosel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: widget.movieModellist.length,
            itemBuilder: (BuildContext context, int itemIndex,
                    int pageViewIndex) =>
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDetails(
                                  movieModel: widget.movieModellist[itemIndex],
                                )));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.fill,
                      imageUrl: kmoviedbImageURL +
                          widget.movieModellist[itemIndex].posterPath.toString(),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              //viewportFraction: 0.1,
            )),
      ],
    );
  }
}