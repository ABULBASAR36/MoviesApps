// import 'package:flutter/material.dart';

// import 'package:moviesapps/model/movie_model.dart';
// import 'package:moviesapps/service/api_service.dart';  
// import 'package:moviesapps/ui/movie/componants/movie_carousel.dart';
// import 'package:moviesapps/ui/movie/movie_category.dart';

// class MovieHome extends StatefulWidget {
//   const MovieHome({super.key});

//   @override
//   State<MovieHome> createState() => _MovieHomeState();
// }

// class _MovieHomeState extends State<MovieHome> {
//   ApiService apiService = ApiService();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           SizedBox(height: 8),
//           FutureBuilder<List<MovieModel>>(
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               }

//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               }

//               if (snapshot.hasData) {
//                 List<MovieModel> movieList = snapshot.data ?? [];

//                 // Pass the movieList correctly to the MovieCarousel
//                 return MovieCarousel(movieList: movieList, movieModellist: [],);
//               }

//               return Center(child: Text('No data available'));
//             },
//             future: apiService.getMovieData(MovieType.nowPlaying),
//           ),
//           SizedBox(height: 8),
//           Expanded(
//             child: const SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Text(
//                     "Popular movie",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   SizedBox(height: 8),
//                   SizedBox(
//                     height: 200,
//                     child: MovieCategory(
//                       movieType: MovieType.popular,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Top Rated movie",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   SizedBox(height: 8),
//                   SizedBox(
//                     height: 200,
//                     child: MovieCategory(
//                       movieType: MovieType.topRated,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Up Coming movie",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   SizedBox(height: 8),
//                   SizedBox(
//                     height: 200,
//                     child: MovieCategory(
//                       movieType: MovieType.upcoming,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }