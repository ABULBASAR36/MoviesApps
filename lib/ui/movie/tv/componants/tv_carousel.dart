import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviesapps/constants/constants.dart';
import 'package:moviesapps/model/tv_model.dart';
import 'package:moviesapps/ui/movie/tv/tv_details.dart';
//import 'package:moviesapps/ui/tv_details_page.dart';

class TvCarousel extends StatefulWidget {
  final List<TvModel> tvlist;

  const TvCarousel({super.key, required this.tvlist});

  @override
  State<TvCarousel> createState() => _TvCarouselState();
}

class _TvCarouselState extends State<TvCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.tvlist.length,
      itemBuilder: (context, itemIndex, pageViewIndex) {
        // Ensure posterPath is not null before using it
        String posterPath = widget.tvlist[itemIndex].posterPath ?? '';
        String imageUrl = kmoviedbImageurl + posterPath;

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TvDetailsPage(tvModel: widget.tvlist[itemIndex]),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.error, color: Colors.red),
              ),
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
      ),
    );
  }
}