import 'package:flutter/material.dart';

//Models
import "../models/movie.dart";

class MovieTile extends StatelessWidget {
  //final GetIt _getIt = GetIt.instance();

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
          _moviePosterWidget(movie!.posterURL()),
          _movieInfoWidget(),
        ],
      ),
    );
  }

  Widget _movieInfoWidget() {
    return Container(
      height: height,
      width: width! * 0.66,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
              Text(
                movie!.rating.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height! * 0.02, 0, 0),
            child: Text(
              "${movie!.releaseDate} | ${movie!.language!.toUpperCase()} | R: ${movie!.isAdult.toString().toUpperCase()}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.5,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height! * 0.07, 0, 0),
            child: Text(
              movie!.description!,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moviePosterWidget(String _imageUrl) {
    return Container(
      height: height,
      width: width! * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_imageUrl),
        ),
      ),
    );
  }
}
