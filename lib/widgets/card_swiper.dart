import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({required this.movies});

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    //Este widget es el loading, para el caso de que la lista de películas esté vacia
    if(movies.isEmpty){
       return Container(
         width: double.infinity,
         height: _size.height * 0.5,
         margin: EdgeInsets.only(top: 10.0),
         child: Center(
           child: CircularProgressIndicator(),
         ),
       );
    }
    return Container(
      width: double.infinity,
      height: _size.height * 0.5,
      margin: EdgeInsets.only(top: 10.0),      
      child:     
      Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: _size.width * 0.7,
        itemHeight: _size.height * 0.9,
        itemBuilder: (_, index) {
          final movie = movies[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/giphy.gif'),
              image: NetworkImage(movie.getPosterImg),
              height: 550,
              fit: BoxFit.cover,
            ),
          );
        },
        onTap: (index) =>
            Navigator.pushNamed(context, 'details', arguments: movies[index]),
      ),
    );
  }
}
