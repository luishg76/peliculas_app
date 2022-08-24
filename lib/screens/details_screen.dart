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
              _CustomAppBar(),
              SliverList(
              delegate: SliverChildListDelegate(
                [_PosterAndTitle(),
                 _OverView(),
                 _OverView(),
                 _OverView(),
                 _OverView(),
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
                  child: Text('movie.title', style: TextStyle(fontSize:16),)
              ),
            titlePadding: EdgeInsets.all(0),
            centerTitle: true,
            background: FadeInImage(
              placeholder: AssetImage('assets/giphy.gif'),
              image:AssetImage('assets/300x400.png'), //NetworkImage('https://via.placeholder.com/300x400'),
              fit: BoxFit.cover,
              )
            ),
   );
  }
}

class _PosterAndTitle extends StatelessWidget {
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
              image:AssetImage('assets/300x400.png'), //NetworkImage('https://via.placeholder.com/300x400'),
              fit: BoxFit.cover,
              ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(  
              crossAxisAlignment: CrossAxisAlignment.start, 
              mainAxisAlignment: MainAxisAlignment.center,                                  
              children: [
                Text('movie.title',style: _textTheme.headline5,overflow: TextOverflow.ellipsis,maxLines: 2,),
                Text('movie.originalTitle',style: _textTheme.subtitle1,overflow: TextOverflow.ellipsis,),                
                Row(                  
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                    SizedBox(width: 5.0,),
                    Text('movie.voteAverage',style: _textTheme.caption,)
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),      
      child: Text('Laboris quis duis sunt tempor aliquip Lorem et minim nisi mollit commodo minim est. Velit culpa sunt do deserunt tempor ipsum tempor veniam ullamco enim ea proident officia reprehenderit. Laboris mollit consequat velit qui veniam eiusmod aute velit cillum consequat sunt ullamco minim. Fugiat fugiat velit sint sunt laboris fugiat pariatur adipisicing esse commodo voluptate.',
             style: Theme.of(context).textTheme.subtitle2,textAlign: TextAlign.justify,),
    );
  }

}