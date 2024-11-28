import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviesapps/constants/constants.dart';
import 'package:moviesapps/model/tv_model.dart';
import 'package:moviesapps/ui/movie/tv/tv_details.dart';

class TvListItem extends StatelessWidget {

final TvModel tvModel;

  const TvListItem({super.key,required this.tvModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TvDetailsPage(tvModel: tvModel)));
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
                      
                      fit:BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageUrl: kmoviedbImageurl+tvModel.posterPath.toString()),
            ),
             SizedBox(height: 5,),
            Text(
              tvModel.originalName.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontWeight:FontWeight.w300),
            ),
      
      
           Row(
             children: [
               RatingBarIndicator(
                rating:tvModel.voteAverage ?? 0,
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
      
              SizedBox(width: 5,),
      
              Text(
                  tvModel.voteAverage == null
                      ? ""
                      : tvModel.voteAverage.toString(),
                  style: TextStyle(color: Colors.white),
                )
      
             ],
           )
      
      
        ],
      
        ),
      ),
    );
  }
}