import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class SearchMovie extends SearchDelegate{
  
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar';
  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
    IconButton(
      onPressed:()=>this.query='', 
      icon:Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: ()=>close(context, null), 
      icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return Text('builResults:10');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty) return _emptycontainer();
   
   final movies_found=Provider.of<MoviesProvider>(context);
   return FutureBuilder(
      future: movies_found.getMoviesSearch(movietitle: query),
      builder:(_,asyncsapshot)
      {
        if(!asyncsapshot.hasData) return _emptycontainer();
        else 
        {
          final lstfound=asyncsapshot.data! as List<Movie>;
           return Container(
            child: ListView.builder(
              itemCount: lstfound.length,
              itemBuilder: (_, int index)=>_MovieItems(context,lstfound[index]),                 
              )
            );
        }        
      });    
  }

  Widget _emptycontainer(){
     return Container(
      child: Center(
        child:Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 150,) 
        ),
    );
  }

  Widget _MovieItems(BuildContext context, Movie movie){
      movie.heroId='search-${movie.id}';
      return ListTile(
            leading: Hero(
              tag: movie.heroId!,
              child: FadeInImage(
                image:NetworkImage(movie.getPosterImg), 
                placeholder: AssetImage('assets/300x400.png'),
                width: 30,
                fit: BoxFit.contain,
                ),
            ),
            title:Text(movie.title,maxLines: 1,overflow: TextOverflow.ellipsis,),
            onTap: () =>
            Navigator.pushNamed(context, 'details', arguments: movie),

      );
    }
  } 