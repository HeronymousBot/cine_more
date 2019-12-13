import 'package:cinemore/api/MovieController.dart';
import 'package:cinemore/model/Movie.dart';
import 'package:cinemore/model/Result.dart';
import 'package:cinemore/model/Review.dart';
import 'package:cinemore/ui/cell/ResultCell.dart';
import 'package:cinemore/ui/cell/MovieOverviewCell.dart';
import 'package:cinemore/ui/cell/MovieReviewCell.dart';
import 'package:flutter/material.dart';

class MovieDetailActivity extends StatefulWidget {
  final int movieId;

  MovieDetailActivity({Key key, this.movieId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieDetailActivityState();
  }
}

class MovieDetailActivityState extends State<MovieDetailActivity> {
  Movie currentMovie;
  List<Review> reviews = List<Review>();
  List<Result> similarMovies;

  @override
  void initState() {
    super.initState();
    _getMovieDetails();
    _getMovieReviews();
    _fetchSimilarMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[800]),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: currentMovie != null
          ? ListView(
              shrinkWrap: true,
              children: <Widget>[
                MovieOverviewCell(movie: currentMovie),
                SizedBox(
                  height: 32,
                ),
                reviews != null
                    ? Container(
                        decoration: BoxDecoration(color: Colors.white),
                        margin: EdgeInsets.only(left: 24),
                        child: Text(
                          reviews.length > 0
                              ? 'Reviews'
                              : 'No reviews available',
                          style:
                              TextStyle(fontSize: 24, color: Colors.grey[800]),
                        ))
                    : SizedBox.shrink(),
                reviews != null
                    ? Container(
                        decoration: BoxDecoration(color: Colors.white),
                        height: reviews.length > 0 ? 250 : 0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return MovieReviewCell(reviews[index]);
                          },
                          itemCount: reviews.length,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  margin: EdgeInsets.only(left: 24),
                  child: similarMovies != null
                      ? Text(
                          'Similar movies',
                          style:
                              TextStyle(fontSize: 24, color: Colors.grey[800]),
                        )
                      : SizedBox.shrink(),
                ),
                similarMovies != null
                    ? Container(
                        decoration: BoxDecoration(color: Colors.white),
                        height: 300,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 200,
                                height: 475,
                                margin: EdgeInsets.symmetric(
                                    horizontal: index == 0 ? 24 : 12,
                                    vertical: 16),
                                child:
                                    ResultCell(similarMovies[index], context));
                          },
                          itemCount: similarMovies.length,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            )
          : Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  void _getMovieDetails() {
    MovieController().fetchMovieDetail(widget.movieId).then((response) {
      setState(() {
        currentMovie = response;
      });
    });
  }

  void _fetchSimilarMovies() {
    MovieController().fetchSimilarMovies(widget.movieId).then((response) {
      setState(() {
        similarMovies = response.results;
      });
    });
  }

  void _getMovieReviews() {
    MovieController().fetchReviews(widget.movieId).then((response) {
      setState(() {
        reviews = response.reviews;
      });
    });
  }
}
