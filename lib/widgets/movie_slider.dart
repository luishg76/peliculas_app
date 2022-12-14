import 'package:flutter/material.dart';
import '../models/models.dart';

class MovieSlider extends StatefulWidget {  
  final List<Movie> movies; 
  final Function onNexPage;
  MovieSlider({required this.movies,required this.onNexPage});
  

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController=ScrollController();

  @override
  void initState() {
    scrollController.addListener(() 
    {
      if(scrollController.position.pixels>=scrollController.position.maxScrollExtent-500)
         widget.onNexPage();              
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: _size.height * 0.38,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Populares',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, index) => _MoviePoster(movie: widget.movies[index]),              
              ),
        )
      ]),
    );
  } 
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  _MoviePoster({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId='slider-${movie.id}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      width: 130,
      height: 190,
      child: Column(children: [
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: movie),
          child: Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/giphy.gif'),
                image: NetworkImage(movie.getPosterImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          movie.getTitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
