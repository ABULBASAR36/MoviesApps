import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:moviesapps/constants/constants.dart';
import 'package:moviesapps/model/tv_model.dart';
import 'package:moviesapps/ui/movie/tv/tv_details.dart';

class TVCarusel extends StatefulWidget {
  final List<TvModel> tvModelList;
  const TVCarusel({super.key,required this.tvModelList});

  @override
  State<TVCarusel> createState() => _TVCaruselState();
}

class _TVCaruselState extends State<TVCarusel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: widget.tvModelList.length,
            itemBuilder: (BuildContext context, int itemIndex,
                int pageViewIndex) =>
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TVDetails(
                              tvModel: widget.tvModelList[itemIndex],
                            )));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.fill,
                      imageUrl: kmoviedbImageURL +
                          widget.tvModelList[itemIndex].posterPath.toString(),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
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