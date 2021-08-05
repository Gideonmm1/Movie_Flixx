import 'package:flutter/material.dart';

//Models
import "../models/movie.dart";

class StartPageMovieTile extends StatelessWidget {
  //final GetIt _getIt = GetIt.instance();

  final double? height;
  final double? width;
  final Movie? movie;

  StartPageMovieTile({
    this.width,
    this.height,
    this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _moviePosterWidget(movie!.posterURL()),
            _movieInfoWidget(),
          ],
        ),
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

  Widget _movieInfoWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width! * 0.35,
          child: Text(
            movie!.name!,
            softWrap: false,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Text(
          movie!.rating!.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
