import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'f32ccd05c2611150e4ed3ffe3e2c5093';
  String _baseUrl = 'api.themoviedb.org';
  String _lenguage = 'es-ES';
  int _page=0;
  int _cantPage=0;
  List<Movie> onNowMovies = [];
  List<Movie> onPopular = [];

  MoviesProvider() {
    getNowPlayingMovies();
    getPopular();
  }

  Future<String> _getJsonData(String segment, [int page=1])async {
      var url = Uri.https(_baseUrl,segment,
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
  
}
