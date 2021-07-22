import 'package:flutter/material.dart';

//Packages
import "package:get_it/get_it.dart";

//Models
import "../models/movie.dart";

class MovieTile extends StatelessWidget {
  final double? height;
  final double? width;
  final Movie? movie;

  MovieTile({
    this.width,
    this.height,
    this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: _moviePosterWidget(movie!.posterPath!),
          ),
          Flexible(
            child: _movieInfoWidget(),
          ),
        ],
      ),
    );
  }

  Widget _movieInfoWidget() {
    return Container(
      height: height,
      width: width! * 0.76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  width: width! * 0.7,
                  child: Text(
                    movie!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  movie!.rating.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height! * 0.02, 0, 0),
            child: Text(
              "Tagline: ${movie!.tagline!}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height! * 0.02, 0, 0),
            child: Text(
              "${movie!.releaseDate} | ${movie!.language!.toUpperCase()} | R: ${movie!.isAdult.toString().toUpperCase()}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height! * 0.07, 0, 0),
            child: Text(
              movie!.description!,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moviePosterWidget(String _imageUrl) {
    var imagePath = "https://image.tmdb.org/t/p/w500$_imageUrl";
    return Container(
      height: height,
      width: width! * 0.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imagePath),
        ),
      ),
    );
  }
}
