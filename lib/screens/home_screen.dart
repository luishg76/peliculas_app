import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movie_provider.dart';
import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //se crea una instancia del provider de peliculas
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en Cines'),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          IconButton(icon: Icon(Icons.search_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          //Películas en Cines
          CardSwiper(movies: moviesProvider.onNowMovies),
          //Películas populares
          Container(
            child: MovieSlider(
              movies: moviesProvider.onPopular,
              onNexPage:()=> moviesProvider.getPopular(),
              ),
            margin: EdgeInsets.only(top: 15.0),
          ),
        ]),
      ),
    );
  }
}
