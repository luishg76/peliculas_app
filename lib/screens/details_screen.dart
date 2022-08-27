import 'package:flutter/material.dart';
import 'package:peliculas_app/widgets/widgets.dart';

import '../models/models.dart';

class DetailsScreen extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    final Movie movie=ModalRoute.of(context)!.settings.arguments as Movie;    
    return Scaffold(
      body: CustomScrollView(
           slivers:[
              _CustomAppBar(movie),
              SliverList(
              delegate: SliverChildListDelegate(
                [_PosterAndTitle(movie),
                 _OverView(movie.overview),
                 _OverView(movie.overview),
                 _OverView(movie.overview), 
                 _OverView(movie.overview),               
                 CastingSlider(),
                ]
               ),
             ),      
          ],
          ),      
    );
  }
}

class _CustomAppBar extends StatelessWidget{
  final Movie movie;

  const _CustomAppBar(this.movie);
  @override
  Widget build(BuildContext context) {
   return SliverAppBar(
          backgroundColor: Colors.indigo,
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(              
             title: Container(
                  width: double.infinity,
                  alignment: Alignment.bottomCenter, 
                  padding: EdgeInsets.only(bottom: 10),                         
                  color: Colors.black12,
                  child: Text(movie.getTitle, style: TextStyle(fontSize:16),)
              ),
            titlePadding: EdgeInsets.all(0),
            centerTitle: true,
            background: FadeInImage(
              placeholder: AssetImage('assets/giphy.gif'),
              image:NetworkImage(movie.getBackDropPath),
              fit: BoxFit.cover,
              )
            ),
   );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle(this.movie);
  @override
  Widget build(BuildContext context) {  
    final _textTheme=Theme.of(context).textTheme;  
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      width: 130,
      height: 190,
      child: Row(        
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/300x400.png'),
              image: NetworkImage(movie.getPosterImg),
              fit: BoxFit.cover,
              ),
          ),
          Container(            
            width: 230,
            margin: EdgeInsets.only(left: 10.0),
            child: Column(  
              crossAxisAlignment: CrossAxisAlignment.start, 
              mainAxisAlignment: MainAxisAlignment.center,                                  
              children: [
                Text(movie.getTitle, style:_textTheme.headline5,overflow: TextOverflow.ellipsis,maxLines: 2,),
                Text(movie.originalTitle, style:_textTheme.subtitle1,overflow: TextOverflow.ellipsis,),                
                Row(                  
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                    SizedBox(width: 5.0,),
                    Text('${movie.voteAverage}',style: _textTheme.caption,)
                  ],
                ),
              ],
            ),
          )
        ]
        ),
       
    );
  }
}

class _OverView extends StatelessWidget {
  final String overview;

  const _OverView(this.overview);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),      
      child: Text(overview,style: Theme.of(context).textTheme.subtitle2,textAlign: TextAlign.justify,),
    );
  }

}