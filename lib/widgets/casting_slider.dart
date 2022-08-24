import 'package:flutter/material.dart';

class CastingSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 205,      
      margin: EdgeInsets.only(bottom: 30),
      child: Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (_, int index)=>_CastCard(),                  
            ),
          ), 
    );
  }
}

class _CastCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {   
    return Container(
           width: 120,
           height: 200,
           margin: EdgeInsets.only(left: 8),           
           child:Column(
             children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/300x400.png'),
                    image:AssetImage('assets/300x400.png'), //NetworkImage('https://via.placeholder.com/300x400'),
                    fit: BoxFit.cover,
                    ),
                ),                
                Text('actor.name', maxLines: 2, overflow: TextOverflow.ellipsis,)
            ]),
    );
  }
}

