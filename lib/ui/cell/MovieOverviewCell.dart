import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemore/model/Movie.dart';
import 'package:cinemore/provider/FirebaseManager.dart';

import 'package:flutter/material.dart';

class MovieOverviewCell extends StatefulWidget {
  Movie movie;

  MovieOverviewCell({Key key, this.movie}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieOverviewCellState(this.movie);
  }
}

class MovieOverviewCellState extends State<MovieOverviewCell> {
  Movie movieItem;
  bool movieInFavorites = true;
  bool movieInWishlist = true;
  static const String basePosterUrl =
      'https://image.tmdb.org/t/p/w600_and_h900_bestv2';

  MovieOverviewCellState(this.movieItem);

  @override
  void initState() {
    super.initState();
    _movieInFavorites(widget.movie);
    _movieInWishlist(widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                movieItem.title,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              elevation: 6.0,
              child: CachedNetworkImage(
                imageUrl: '$basePosterUrl${movieItem.posterPath}',
                height: 375,
                width: 250,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  alignment: Alignment.center,
                  child: Text(
                    movieItem.voteAverage.toString(),
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                  decoration: new BoxDecoration(
                    color: returnColor(movieItem.voteAverage),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  '${movieItem.genres.elementAt(0).name}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Text(
                movieItem.overview,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: Colors.grey[800]),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 36,
                    child: FlatButton(
                      onPressed: () async {
                        if (movieInWishlist) {
                          setState(() {
                            FirebaseManager().deleteFromWishlist(movieItem);
                            _movieInWishlist(movieItem);
                          });
                        } else {
                          setState(() {
                            FirebaseManager().addToWishlist(movieItem);
                            _movieInWishlist(movieItem);
                          });
                        }
                      },
                      color: Colors.pink,
                      //minWidth: MediaQuery.of(context).size.width / 2 - 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            movieInWishlist ? 'On Wishlist' : 'Want to see',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Icon(
                            movieInWishlist ? Icons.check : Icons.add,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 36,
                    child: FlatButton(
                        onPressed: () async {
                          if (movieInFavorites) {
                            setState(() {
                              FirebaseManager().deleteFromFavorites(movieItem);
                              _movieInFavorites(movieItem);
                            });
                          } else {
                            setState(() {
                              FirebaseManager().addToFavorites(movieItem);
                              _movieInFavorites(movieItem);
                            });
                          }
                        },
                        //width: MediaQuery.of(context).size.width / 2 - 36,
                        color: Colors.pink,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              !movieInFavorites ? 'Favorite' : '',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Icon(
                              movieInFavorites ? Icons.favorite : Icons.add,
                              color: Colors.white,
                            )
                          ],
                        )),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void _movieInFavorites(Movie movie) {
    FirebaseManager().checkIfInFavorites(movie.id).then((inFavorites) {
      setState(() {
        movieInFavorites = inFavorites;
        print(movieInFavorites);
      });
    });
  }

  bool _movieInWishlist(Movie movie) {
    FirebaseManager().checkIfInWishlist(movie.id).then((inWishlist) {
      setState(() {
        movieInWishlist = inWishlist;
        print(movieInWishlist);
      });
    });
  }

  Color returnColor(double voteAverage) {
    if (voteAverage < 6) {
      return Colors.red;
    }
    if (voteAverage >= 6 && voteAverage < 8) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }
}
