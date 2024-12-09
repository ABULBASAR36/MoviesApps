import 'package:flutter/material.dart';

import 'package:moviesapps/model/tv_model.dart';
import 'package:moviesapps/service/api_service.dart';
import 'package:moviesapps/ui/movie/tv/componants/tv_carousel.dart';
import 'package:moviesapps/ui/movie/tv/tv_category.dart';



class TVPage extends StatefulWidget {
  const TVPage({super.key});

  @override
  State<TVPage> createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<TvModel> tvModel = snapshot.data ?? [];
                return TVCarusel(
                  tvModelList: tvModel,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            future: apiService.getTVData(TvType.airingTody),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // Popular TV Section
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [Colors.blue, Colors.green, Colors.yellow],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                  },
                  child: Text(
                    "Popular TV",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 200,
                  child: TvCategory(
                    tvType: TvType.popular,
                  ),
                ),

                // Top Rated TV Section
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [Colors.purple, Colors.orange, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                  },
                  child: Text(
                    "Top Rated TV",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 200,
                  child: TvCategory(
                    tvType: TvType.topRated,
                  ),
                ),

                // On The Air Section
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [Colors.red, Colors.pink, Colors.orange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                  },
                  child: Text(
                    "On The Air",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 200,
                  child: TvCategory(
                    tvType: TvType.onTheAir,
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
