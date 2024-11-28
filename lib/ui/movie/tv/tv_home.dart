import 'package:flutter/material.dart';
import 'package:moviesapps/model/tv_model.dart';
import 'package:moviesapps/service/api_service.dart';
import 'package:moviesapps/ui/movie/tv/componants/tv_carousel.dart';
import 'package:moviesapps/ui/movie/tv/tv_category.dart';

class TvHome extends StatefulWidget {
  const TvHome({super.key});

  @override
  State<TvHome> createState() => _TvHomeState();

}

class _TvHomeState extends State<TvHome> {

  ApiService apiService=ApiService();
  @override
  Widget build(BuildContext context) {
   return Container(
      child: Column(
          children: [
             SizedBox(height: 8,),
          FutureBuilder(builder: (context,snapsot){
            if(snapsot.hasData)
            {
              List<TvModel>tvdata=snapsot.data??[];
              
        return TvCarousel(tvlist: tvdata,);
            }
            return Center(
              child: const CircularProgressIndicator(),
            );
          },
           future: apiService.getTvData(TvType.airing_today),
          ),

           SizedBox(height: 8,),

        Expanded(
             child: const SingleChildScrollView(
               child: Column(children: [
                Text(
                    "Popular tv",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
               
                SizedBox(height: 8,),
               
                SizedBox(
                    height: 200,
                    child:TvCategory(
                      tvType: TvType.popular,
                    ),
                  ),
               
                  SizedBox(height: 8,),
                  Text(
                    "Top Rated tv",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
               
                   SizedBox(height: 8,),
               
                     SizedBox(
                    height: 200,
                    child: TvCategory(
                      tvType: TvType.top_rated,
                    ),
                  ),
               
               
               
                    SizedBox(height: 8,),
                  Text(
                    "on_the_air",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
               
                   SizedBox(height: 8,),
               
                     SizedBox(
                    height: 200,
                    child: TvCategory(
                      tvType: TvType.on_the_air,
                    ),
                  ),
               
               
               ],),
             ),
           )




          ],
      ),
    );
  }
}