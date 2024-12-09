// import 'package:flutter/material.dart';
// import 'package:moviesapps/service/api_service.dart'; // Make sure this is the correct path

// class TVPage extends StatefulWidget {
//   const TVPage({super.key});

//   @override
//   State<TVPage> createState() => _TVPageState();
// }

// class _TVPageState extends State<TVPage> {
//   final ApiService apiService = ApiService();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           FutureBuilder<List<TVModel>>(
//             future: apiService.getTVData(TvType.airingToday),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text(
//                     'Error: ${snapshot.error}',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 );
//               }
//               if (snapshot.hasData) {
//                 List<TVModel> tvModel = snapshot.data!;
//                 return TVCarousel(tvModelList: tvModel);
//               }
//               return const Center(
//                 child: Text(
//                   'No data available',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 8),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SectionTitle(title: "Popular TV"),
//                   TvCategory(tvType: TvType.popular),
//                   const SectionTitle(title: "Top Rated TV"),
//                   TvCategory(tvType: TvType.topRated),
//                   const SectionTitle(title: "On The Air"),
//                   TvCategory(tvType: TvType.onTheAir),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SectionTitle extends StatelessWidget {
//   final String title;
//   const SectionTitle({super.key, required this.title});

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

// // Dummy ApiService and TVModel
// class ApiService {
//   Future<List<TVModel>> getTVData(TvType type) async {
//     await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
//     return List.generate(5, (index) => TVModel(title: "TV Show $index", imageUrl: "https://via.placeholder.com/150"));
//   }
// }

// class TVModel {
//   final String title;
//   final String imageUrl;

//   TVModel({required this.title, required this.imageUrl});
// }

// // Enum for TV Types
// enum TvType { airingToday, popular, topRated, onTheAir, on_the_air, similar }

// // TVCarousel Widget
// class TVCarousel extends StatelessWidget {
//   final List<TVModel> tvModelList;

//   const TVCarousel({super.key, required this.tvModelList});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: tvModelList.length,
//         itemBuilder: (context, index) {
//           final tv = tvModelList[index];
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 8),
//             child: Column(
//               children: [
//                 Image.network(tv.imageUrl, width: 100, height: 150, fit: BoxFit.cover),
//                 const SizedBox(height: 8),
//                 Text(
//                   tv.title,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // TvCategory Widget
// class TvCategory extends StatelessWidget {
//   final TvType tvType;
//   const TvCategory({super.key, required this.tvType});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<TVModel>>(
//       future: ApiService().getTVData(tvType),
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
//           List<TVModel> tvList = snapshot.data!;
//           return SizedBox(
//             height: 200,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: tvList.length,
//               itemBuilder: (context, index) {
//                 final tv = tvList[index];
//                 return Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Column(
//                     children: [
//                       Image.network(tv.imageUrl, width: 100, height: 150, fit: BoxFit.cover),
//                       const SizedBox(height: 8),
//                       Text(
//                         tv.title,
//                         style: const TextStyle(color: Colors.white),
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
