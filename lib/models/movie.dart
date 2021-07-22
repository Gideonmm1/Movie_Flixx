//Packages
import "package:get_it/get_it.dart";

//Models
import "../models/app_config.dart";

class Movie {
  final String? name;
  final String? language;
  final String? description;
  final bool? isAdult;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final num? rating;
  final String? tagline;

  Movie(
      {this.name,
      this.language,
      this.description,
      this.isAdult,
      this.posterPath,
      this.backdropPath,
      this.releaseDate,
      this.rating,
      this.tagline});

  factory Movie.fromJson(Map<String, dynamic> _json) {
    return Movie(
        name: _json['title'],
        language: _json['original_language'],
        posterPath: _json['poster_path'],
        description: _json['overview'],
        isAdult: _json['adult'],
        backdropPath: _json['backdrop_path'],
        releaseDate: _json['release_date'],
        rating: _json['vote_average'],
        tagline: _json['tagline']);
  }
  String posterURL() {
    final AppConfig _appConfig = GetIt.instance.get<AppConfig>();
    return "${_appConfig.BASE_IMAGE_API_URL}${this.posterPath}";
  }
}
