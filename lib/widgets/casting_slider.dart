import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingSlider extends StatelessWidget {
  final int idmovie;
  
  const CastingSlider({required this.idmovie});
  @override
  Widget build(BuildContext context) {
    final movieProvider=Provider.of<MoviesProvider>(context,listen: false);
    return FutureBuilder(
      future:movieProvider.getMovieCasts(idmovie: idmovie) ,
      builder: (_,AsyncSnapshot<List<Cast>> snapshot)
      {
        if(!snapshot.hasData)
        {
          return Container(
                  child:CupertinoActivityIndicator(),
          );
        }
        
        final lstcast=snapshot.data!;
        return Container(
                width: double.infinity,
                height: 205,      
                margin: EdgeInsets.only(bottom: 30),
                child: Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:10,
                      itemBuilder: (_, index)=>_CastCard(actor:lstcast[index]),                  
                    ),
                ), 
             );      
          }
      );    
  }
}

class _CastCard extends StatelessWidget{
  final Cast actor;

  const _CastCard({required this.actor});
  @override
  Widget build(BuildContext context) {   
    return Container(
           width: 120,
           height: 200,
           margin: EdgeInsets.only(left: 10),           
           child:Column(
             children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/300x400.png'),
                    image:NetworkImage(actor.getProfilePath),
                    height: 150,
                    fit: BoxFit.cover,
                    ),
                ),                
                Text(actor.name, maxLines: 2, overflow: TextOverflow.ellipsis,)
            ]),
    );
  }
}

