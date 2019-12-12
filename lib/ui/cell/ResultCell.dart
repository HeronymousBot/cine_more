import 'package:cinemore/model/Genre.dart';
import 'package:cinemore/model/Result.dart';
import 'package:cinemore/ui/activity/MovieDetailActivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ResultCell extends StatelessWidget {
  Result result;
  BuildContext context;
  String view;
  List<Genre> genres;

  static const String basePosterUrl =
      'https://image.tmdb.org/t/p/w600_and_h900_bestv2';

  ResultCell(this.result, this.context, {this.view, this.genres});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailActivity(
                      movieId: result.id,
                    )));
      },
      child: view == 'discover'
          ? Card(
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: '$basePosterUrl${result.posterPath}',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(4.0),
                    child: Text(
                      "${result.title}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(4.0),
                    child:
                        Text('Released in: ${formatDate(result.releaseDate)}'),
                  ),
                  Container(
                    margin: EdgeInsets.all(4.0),
                    child: Text(
                      '${getGenreById(result.genreIds[0], genres)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
          : Card(
              elevation: 4.0,
              child: Container(
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: '$basePosterUrl${result.posterPath}',
                ),
              ),
            ),
    );
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(date);

    return formattedDate;
  }

  String getGenreById(int id, List<Genre> genres) {
    Genre queriedGenre = genres.singleWhere((item) => item.id == id);
    return queriedGenre.name;
  }
}
