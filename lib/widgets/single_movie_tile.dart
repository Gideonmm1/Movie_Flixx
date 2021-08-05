import 'package:flutter/material.dart';

//Models
import "../models/movie.dart";

class SingleMovieTile extends StatelessWidget {
  //final GetIt _getIt = GetIt.instance();

  final double? height;
  final double? width;
  final Movie? movie;

  SingleMovieTile({
    this.width,
    this.height,
    this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _backgroundWidget() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(movie!.backdropPath!),
        ),
      ),
    );
  }

  Widget _foregroundWidget() {
    return Container(
      height: height! * 0.88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: NetworkImage(movie!.posterURL()))),
          )
        ],
      ),
    );
  }
}
