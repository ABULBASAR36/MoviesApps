import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;

// Define the ProgramType enum if it exists in your application
enum ProgramType { movie, tv }

// Define the CastModel class
class CastModel {
  final int id;
  final String name;
  final String profileImage;

  CastModel({required this.id, required this.name, required this.profileImage});

  // Factory method to parse JSON into a CastModel
  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'],
      name: json['name'],
      profileImage: json['profile_path'] ?? '',
    );
  }
}

// Define ApiService for fetching data
class ApiService {
  Future<List<CastModel>> getCastList(int id, ProgramType type) async {
    // Replace API_URL with your actual API endpoint
    final response = await http.get(Uri.parse('https://api.example.com/cast?id=$id&type=${type.name}'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((e) => CastModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load cast');
    }
  }
}

// Define the CastListItem widget for rendering each cast member
class CastListItem extends StatelessWidget {
  final CastModel castModel;

  const CastListItem({Key? key, required this.castModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Display profile image or placeholder
          CircleAvatar(
            radius: 40,
            backgroundImage: castModel.profileImage.isNotEmpty
                ? NetworkImage(castModel.profileImage)
                : null,
            child: castModel.profileImage.isEmpty
                ? Icon(Icons.person, size: 40)
                : null,
          ),
          const SizedBox(height: 8),
          // Display cast member's name
          Text(
            castModel.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Define the main CastPage widget
class CastPage extends StatefulWidget {
  final int id;
  final ProgramType type;

  const CastPage({Key? key, required this.id, required this.type}) : super(key: key);

  @override
  State<CastPage> createState() => _CastPageState();
}

class _CastPageState extends State<CastPage> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cast')),
      body: FutureBuilder(
        future: apiService.getCastList(widget.id, widget.type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data is List<CastModel>) {
            List<CastModel> castlist = snapshot.data as List<CastModel>;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: castlist.length,
              itemBuilder: (context, index) {
                return CastListItem(
                  key: ValueKey(castlist[index].id), // Unique key for each item
                  castModel: castlist[index],
                );
              },
            );
          }
          return const Center(child: Text('No Data Found'));
        },
      ),
    );
  }
}