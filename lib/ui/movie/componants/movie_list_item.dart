import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:moviesapps/model/movie_model.dart';
import 'package:moviesapps/ui/movie/movie_details.dart';

import '../../../constants/constants.dart';

class MovieListItem extends StatelessWidget {
  final MovieModel movieModel;

  const MovieListItem({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetails(
                      movieModel: movieModel,
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 140,
                //width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: kmoviedbImageURL + movieModel.posterPath.toString(),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Text(
              movieModel.title.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),

            Row(
              children: [
                RatingBarIndicator(
                  rating: movieModel.voteAverage ?? 0,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 15.0,
                  direction: Axis.horizontal,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  movieModel.voteAverage == null
                      ? ""
                      : movieModel.voteAverage.toString(),
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            // Text(
            //   movieModel.overview.toString(),
            //   style: TextStyle(color: Colors.grey),
            //   overflow: TextOverflow.ellipsis,
            //   maxLines: 3,
            // ),
          ],
        ),
      ),
    );
  }
}