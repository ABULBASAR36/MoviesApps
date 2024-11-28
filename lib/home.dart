import 'package:flutter/material.dart';
import 'package:moviesapps/ui/movie/movie_home.dart';
import 'package:moviesapps/ui/movie/tv/tv_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

int _selectedIndex=0;

Widget getView(){
  if(_selectedIndex== 0)
  {
    return MovieHome();
  }
  else
  {
    return TvHome();
  }

}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Flutter Movie App"),
      ),
      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (Index){
          _selectedIndex=Index;
          setState(() {
            
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.movie),label: "Movie"),
         BottomNavigationBarItem(icon: Icon(Icons.tv),label: "TV"),
      ]
      ),
    );
  }
}