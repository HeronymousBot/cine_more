import 'Genre.dart';

class Movie {
  String backdropPath;
  String homepage;
  int id;
  String title;
  double voteAverage;
  String overview;
  String posterPath;
  List<Genre> genres = [];

  MovieDetail({
    double voteAverage,
    String backdropPath,
    String homepage,
    int id,
    String posterPath,
    String title,
    String overview,
    List<Genre> genres,
  }) {
    this.title = title;
    this.posterPath = posterPath;
    this.backdropPath = backdropPath;
    this.homepage = homepage;
    this.overview = overview;
    this.id = id;
    this.voteAverage = voteAverage;
    this.genres = genres;
  }

  Movie.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    voteAverage = json['vote_average'];
    backdropPath = json['backdrop_path'];
    homepage = json['homepage'];
    id = json['id'];
    posterPath = json['poster_path'];
    overview = json['overview'];
    for (int i = 0; i < json['genres'].length; i++) {
      genres.add(Genre(json['genres'][i]));
    }
  }

  Movie.fromFirebase(Map<String, dynamic> json) {
    title = json['title'];
    voteAverage = json['vote_average'];
    backdropPath = json['backdrop_path'];
    homepage = json['homepage'];
    id = json['id'];
    posterPath = json['poster_path'];
    overview = json['overview'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['overview'] = this.overview;
    data['title'] = this.title;
    data['poster_path'] = this.posterPath;
    data['vote_average'] = this.voteAverage;
    data['genre'] = this.genres[0];
    return data;
  }

  Map<String, dynamic> toFirebase() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['overview'] = this.overview;
    data['title'] = this.title;
    data['poster_path'] = this.posterPath;
    data['vote_average'] = this.voteAverage;

    return data;
  }
}
