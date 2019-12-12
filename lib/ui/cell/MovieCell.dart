import 'package:cinemore/model/Movie.dart';
import 'package:cinemore/ui/activity/MovieDetailActivity.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieCell extends StatelessWidget {
  Movie movie;
  BuildContext context;
  static const String basePosterUrl =
      'https://image.tmdb.org/t/p/w600_and_h900_bestv2';

  MovieCell(this.movie, this.context);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailActivity(movieId: movie.id,)));
      },
      child: Container(
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: '$basePosterUrl${movie.posterPath}',
        ),
      ),
    );
  }
}