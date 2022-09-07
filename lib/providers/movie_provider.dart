import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/helpers/debouncer.dart';
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'f32ccd05c2611150e4ed3ffe3e2c5093';
  String _baseUrl = 'api.themoviedb.org';
  String _lenguage = 'es-ES';
  int _page=0;
  
  List<Movie> onNowMovies = [];
  List<Movie> onPopular = [];
  Map<int,List<Cast>> movieCasts={};
  List<Movie> onFound=[];

  final StreamController<List<Movie>> _suggestionStreamController=new StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream{
    return _suggestionStreamController.stream;
  }

  final mydebouncer=Debouncer<String>(duration:Duration(milliseconds: 500));

  MoviesProvider() {
    getNowPlayingMovies();
    getPopular();
  }

  Future<String> _getJsonData(String segment, [int page=1])async {
      final url = Uri.https(_baseUrl,segment,
        {'api_key': _apiKey, 'lenguage': _lenguage, 'page':'$page'});
      final response = await http.get(url);
      if (response.statusCode == 200)return response.body;
       return '';
  }

  getNowPlayingMovies() async {
      final nowMoviesJson=await _getJsonData('/3/movie/now_playing');
      onNowMovies=NowPlaying.fromJson(nowMoviesJson).results;
      notifyListeners();
  }  

  getPopular() async {
      _page++; //Esto es para que me recorra las paginas
      final popularJson=await _getJsonData('/3/movie/popular',_page);
      final popularResponse=Popular.fromJson(popularJson);      
      if(_page==1)
        onPopular=popularResponse.results;
      else
        onPopular = [...onPopular,...popularResponse.results];      
      notifyListeners();
  }

  Future<List<Cast>> getMovieCasts({required int idmovie}) async{
    //Si contiene la lista de actores de la pelicula la retorno
    if(movieCasts.containsKey(idmovie)) return movieCasts[idmovie]!;
    //Si no contiene la lista de actores de la pelicula hago un petición
    //http y la guardo en memoria    
    final jsonData=await this._getJsonData('/3/movie/$idmovie/credits');
    final movieCredits=MovieCredits.fromJson(jsonData);
    movieCasts[idmovie]=movieCredits.cast;
    return movieCredits.cast;
  }

  //Función qeu asigna el query al stream
    void setSuggestionsByQuery(String query) 
    {
       mydebouncer.value='';
       mydebouncer.onValue=(value) async {
         final result=await getMoviesSearch(movietitle: query);
         this._suggestionStreamController.add(result);
       };
      
      final timer=Timer.periodic(Duration(milliseconds: 300), (_){
        mydebouncer.value=query;
      });
      
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());

    }

  Future<List<Movie>> getMoviesSearch({required String movietitle}) async{
     final url = Uri.https(_baseUrl,'/3/search/movie',
        {'api_key': _apiKey, 'lenguage': _lenguage, 'query':movietitle});
      final response = await http.get(url);
      if (response.statusCode == 200)return MoviesFound.fromJson(response.body).results;
      return [];
  }
  
}
