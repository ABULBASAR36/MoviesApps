import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Base URL for image loading (replace this with your actual image base URL)
const String kmoviedbImageurl = "https://image.tmdb.org/t/p/w500";

/// Model for Cast details
class CastModel {
  final String profilePath;
  final String name;
  final String knownForDepartment;

  CastModel({
    required this.profilePath,
    required this.name,
    required this.knownForDepartment,
  });

  /// Factory method to parse JSON into a CastModel
  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      profilePath: json['profile_path'] ?? '',
      name: json['name'] ?? 'Unknown',
      knownForDepartment: json['known_for_department'] ?? 'Unknown',
    );
  }
}

/// CastListItem widget for displaying individual cast member details
class CastListItem extends StatelessWidget {
  final CastModel castModel;

  const CastListItem({super.key, required this.castModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 120,
      child: Column(
        children: [
          // CachedNetworkImage for profile picture
          CachedNetworkImage(
            imageUrl: "$kmoviedbImageurl${castModel.profilePath}",
            imageBuilder: (context, imageProvider) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(height: 5),
          // Display cast name
          Text(
            castModel.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(color: Colors.white),
          ),
          // Display cast department
          Text(
            castModel.knownForDepartment,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

/// Example usage within a Scaffold
class CastPageExample extends StatelessWidget {
  const CastPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of cast data
    final List<CastModel> castList = [
      CastModel(
        profilePath: '/path_to_image.jpg',
        name: 'Actor Name',
        knownForDepartment: 'Acting',
      ),
      CastModel(
        profilePath: '/path_to_image2.jpg',
        name: 'Another Actor',
        knownForDepartment: 'Directing',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Cast List Example')),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castList.length,
        itemBuilder: (context, index) {
          return CastListItem(castModel: castList[index]);
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CastPageExample(),
  ));
}