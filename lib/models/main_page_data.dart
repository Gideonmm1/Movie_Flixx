// Models
import '../models/search_category.dart';
import '../models/movie.dart';

class MainPageData {
  final List<Movie>? movies;
  final int? page;
  final int? movieID;
  final String? searchCategory;
  final String? searchText;

  MainPageData({
    this.movies,
    this.page,
    this.movieID,
    this.searchCategory,
    this.searchText,
  });

  MainPageData.initial()
      : movies = [],
        page = 1,
        searchCategory = SearchCategory.popular,
        searchText = "",
        movieID = 451048;

  MainPageData copyWith(
      {List<Movie>? movies,
      int? page,
      String? searchCategory,
      String? searchText,
      int? movieID}) {
    return MainPageData(
        movies: movies ?? this.movies,
        movieID: movieID ?? this.movieID,
        page: page ?? this.page,
        searchCategory: searchCategory ?? this.searchCategory,
        searchText: searchText ?? this.searchText);
  }
}
