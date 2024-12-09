// import 'package:flutter/material.dart';
// import 'package:moviesapps/model/tv_model.dart';
// import 'package:moviesapps/service/api_service.dart';
// import 'package:moviesapps/ui/movie/tv/componants/tv_carousel.dart';
// import 'package:moviesapps/ui/movie/tv/tv_category.dart';
// import 'package:moviesapps/service/api_service.dart';

// class TvHome extends StatefulWidget {
//   const TvHome({super.key});

//   @override
//   State<TvHome> createState() => _TvHomeState();
// }

// class _TvHomeState extends State<TvHome> {
//   ApiService apiService = ApiService();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           SizedBox(height: 8),
//           FutureBuilder(
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<TvModel> tvdata = snapshot.data ?? [];
//                 return TvCarousel(tvlist: tvdata);
//               }
//               return Center(child: CircularProgressIndicator());
//             },
//             future: apiService.getTVData(TvType.airingToday),
//           ),
//           SizedBox(height: 8),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Text(
//                     "Popular TV Shows",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   SizedBox(height: 8),
//                   SizedBox(
//                     height: 200,
//                     child: TvCategory(tvType: TvType.popular),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Top Rated TV Shows",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   SizedBox(height: 8),
//                   SizedBox(
//                     height: 200,
//                     child: TvCategory(tvType: TvType.topRated),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "On The Air",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   SizedBox(height: 8),
//                   SizedBox(
//                     height: 200,
//                     child: TvCategory(tvType: TvType.onTheAir),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }