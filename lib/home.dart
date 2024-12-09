import 'package:flutter/material.dart';
import 'package:moviesapps/ui/movie/movie_page.dart';
import 'package:moviesapps/ui/movie/tv/tv_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Widget getView() {
    if (_selectedIndex == 0) {
      return MoviePage();
    } else {
      return TVPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [Colors.red, Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
          },
          child: Text(
            "TMDB Rating Movie And TV",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // This color is overridden by the gradient
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movie"),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TV"),
        ],
      ),
    );
  }
}
