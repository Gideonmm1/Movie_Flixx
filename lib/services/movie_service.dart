//Packages
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

//Services
import '../services/http_service.dart';

//Models
import '../models/movie.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPService _http;

  MovieService() {
    _http = getIt.get<HTTPService>();
  }

  Future<List<Movie>?> getPopularMovies({int? page}) async {
    Response? _response = await _http.get('/movie/popular', query: {
      'page': page,
    });
    if (_response!.statusCode == 200) {
      Map _data = _response.data;
      List<Movie>? _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      return _movies;
    } else {
      throw Exception('Couldn\'t load popular movies.');
    }
  }

  Future<List<Movie>?> getUpcomingMovies({int? page}) async {
    Response? _response = await _http.get('/movie/upcoming', query: {
      'page': page,
    });
    if (_response!.statusCode == 200) {
      Map _data = _response.data;
      List<Movie>? _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      return _movies;
    } else {
      throw Exception('Couldn\'t load upcoming movies.');
    }
  }

  Future<List<Movie>?> searchMovies(String? _seachTerm, {int? page}) async {
    Response? _response = await _http.get('/search/movie', query: {
      'query': _seachTerm,
      'page': page,
    });
    if (_response!.statusCode == 200) {
      Map _data = _response.data;
      List<Movie>? _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      return _movies;
    } else {
      throw Exception('Couldn\'t perform movies search.');
    }
  }

  Future<List<String>?> getTrailer(int? _movieID) async {
    Response? _response = await _http.get("/movie/$_movieID/videos");
    final List<String>? list = [];
    if (_response!.statusCode == 200) {
      Map _data = _response.data;

      if (_data['results'] != null) {
        _data['results'].forEach((element) {
          if (element["site"] == "YouTube") {
            list!.add(element["key"]);
          }
        });
        return list;
      } else {
        throw Exception('Couldn\'t get movies trailers.');
      }
    }
  }
}
