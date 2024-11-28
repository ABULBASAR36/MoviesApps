import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviesapps/constants/constants.dart';
import 'package:moviesapps/model/movie_model.dart';
import 'package:moviesapps/ui/movie/movie_details.dart';

class MovieCarousel extends StatefulWidget {


final List<MovieModel>movieList;

  const MovieCarousel({super.key, required this.movieList});

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {




  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.movieList.length, 
      itemBuilder: (context,itemIndex,pageViewIndex)
    {
      return InkWell(
        onTap: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=>
          MovieDetails(movieModel:widget.movieList[itemIndex])));

        },
        child: ClipRRect(
          borderRadius:BorderRadius.circular(10) ,
          child: CachedNetworkImage(
          
          width:double.infinity,
          fit:BoxFit.fill,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageUrl: kmoviedbImageurl+widget.movieList[itemIndex].posterPath.toString()),
        ),
      );
    } ,
    options: CarouselOptions(height: 180,autoPlay: true,enlargeCenterPage: true,aspectRatio: 16/9));
  }
}