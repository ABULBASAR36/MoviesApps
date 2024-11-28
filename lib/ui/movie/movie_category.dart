import 'package:flutter/material.dart';
import 'package:moviesapps/model/movie_model.dart';
import 'package:moviesapps/service/api_service.dart';
import 'package:moviesapps/ui/movie/componants/movie_list_item.dart';

class MovieCategory extends StatefulWidget {
  final MovieType movieType;
  final movieId;
  const MovieCategory({super.key,required this.movieType,this.movieId=0});
  
 

  @override
  State<MovieCategory> createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {

 ApiService apiService=ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( builder:(context,snapshot){
    
    if(snapshot.hasData)
    {
     List<MovieModel>movieList=snapshot.data ?? [];

     return ListView.builder(itemBuilder: (context,index){

     return MovieListItem(movieModel: movieList[index],);
      
     }, itemCount: movieList.length,
     scrollDirection: Axis.horizontal,
     
     );
    }
    return Center(child: CircularProgressIndicator(),);

    },
    future: apiService.getMovieData(widget.movieType,movieID: widget.movieId),
    );
  }
}