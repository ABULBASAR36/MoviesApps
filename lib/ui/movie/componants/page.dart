// import 'package:flutter/material.dart';

// class MoviePage extends StatefulWidget {
//   const MoviePage({Key? key}) : super(key: key);

//   @override
//   State<MoviePage> createState() => _MoviePageState();
// }

// class _MoviePageState extends State<MoviePage> {
//   final ApiService apiService = ApiService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             FutureBuilder<List<MovieModel>>(
//               future: apiService.getMovieData(MovieType.nowPlaying),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                       'Error: ${snapshot.error}',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   );
//                 }
//                 if (snapshot.hasData) {
//                   List<MovieModel> movieModelList = snapshot.data!;
//                   return MovieCarousel(movieList: movieModelList);
//                 }
//                 return const Center(
//                   child: Text(
//                     'No data available',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SectionTitle(title: "Popular Movie"),
//                     MoviesCategory(movieType: MovieType.popular),
//                     const SectionTitle(title: "Top Rated Movie"),
//                     MoviesCategory(movieType: MovieType.topRated),
//                     const SectionTitle(title: "Upcoming Movie"),
//                     MoviesCategory(movieType: MovieType.upcoming),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SectionTitle extends StatelessWidget {
//   final String title;
//   const SectionTitle({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: Text(
//         title,
//         style: const TextStyle(color: Colors.white, fontSize: 20),
//       ),
//     );
//   }
// }

// // Dummy ApiService
// class ApiService {
//   Future<List<MovieModel>> getMovieData(MovieType type) async {
//     await Future.delayed(const Duration(seconds: 2)); // Simulating network delay
//     return List.generate(5, (index) => MovieModel("Movie $index", "https://via.placeholder.com/150"));
//   }
// }

// // Dummy MovieModel
// class MovieModel {
//   final String title;
//   final String imageUrl;
//   MovieModel(this.title, this.imageUrl);
// }

// // Enum for Movie Types
// enum MovieType { nowPlaying, popular, topRated, upcoming, similar }

// // MovieCarousel Widget
// class MovieCarousel extends StatelessWidget {
//   final List<MovieModel> movieList;
//   const MovieCarousel({Key? key, required this.movieList}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: movieList.length,
//         itemBuilder: (context, index) {
//           MovieModel movie = movieList[index];
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 8),
//             child: Column(
//               children: [
//                 Image.network(movie.imageUrl, width: 100, height: 150, fit: BoxFit.cover),
//                 const SizedBox(height: 8),
//                 Text(
//                   movie.title,
//                   style: const TextStyle(color: Colors.white, fontSize: 14),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // MoviesCategory Widget
// class MoviesCategory extends StatelessWidget {
//   final MovieType movieType;
//   const MoviesCategory({Key? key, required this.movieType}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<MovieModel>>(
//       future: ApiService().getMovieData(movieType),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               'Error: ${snapshot.error}',
//               style: const TextStyle(color: Colors.white),
//             ),
//           );
//         }
//         if (snapshot.hasData) {
//           List<MovieModel> movies = snapshot.data!;
//           return SizedBox(
//             height: 200,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: movies.length,
//               itemBuilder: (context, index) {
//                 MovieModel movie = movies[index];
//                 return Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Column(
//                     children: [
//                       Image.network(movie.imageUrl, width: 100, height: 150, fit: BoxFit.cover),
//                       const SizedBox(height: 8),
//                       Text(
//                         movie.title,
//                         style: const TextStyle(color: Colors.white, fontSize: 14),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//         return const Center(
//           child: Text(
//             'No data available',
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//   }
// }
