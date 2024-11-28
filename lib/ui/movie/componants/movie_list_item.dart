import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviesapps/constants/constants.dart';
import 'package:moviesapps/model/movie_model.dart';
import 'package:moviesapps/ui/movie/movie_details.dart';

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
            builder: (context) => MovieDetails(movieModel: movieModel),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 140,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl: kmoviedbImageurl + (movieModel.posterPath ?? ''),
              ),
            ),
            SizedBox(height: 5),
            Text(
              movieModel.title ?? 'No title available',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            Row(
              children: [
                RatingBarIndicator(
                  rating: movieModel.voteAverage ?? 0,
                  itemBuilder: (context, index) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  itemCount: 5,
                  itemSize: 15,
                  direction: Axis.horizontal,
                ),
                SizedBox(width: 5),
                Text(
                  movieModel.voteAverage == null
                      ? "No Rating"
                      : movieModel.voteAverage.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}