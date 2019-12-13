import 'dart:convert';
import 'package:cinemore/model/GenreItem.dart';
import 'package:cinemore/model/Item.dart';
import 'package:cinemore/model/Movie.dart';
import 'package:cinemore/model/ReviewItem.dart';
import 'package:http/http.dart' as http;

class MovieController {
  static const String _apiKey = 'c5850ed73901b8d268d0898a8a9d8bff';
  http.Client client = http.Client();
  final _baseUrl = "http://api.themoviedb.org/3";
  final _findPath = '/find';
  final _discoverPath = '/movie/discover';
  final _searchPath = '/search';

  Future<Item> fetchMovieList(int discoverRequest, int page) async {
    final response = await client.get(_buildDiscoverUrl(discoverRequest, page));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies list');
    }
  }

  Future<Item> fetchSearchResults(String query) async {
    final response = await client.get('$_baseUrl'
        '$_searchPath'
        '/movie?api_key=$_apiKey'
        '&query=$query');
    print(response.body.toString());
    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search movies list');
    }
  }

  Future<Movie> fetchMovieDetail(int movieId) async {
    final response = await client.get('$_baseUrl'
        '/movie'
        '/$movieId'
        '?api_key=$_apiKey');
    print(response.body.toString());
    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to retrieve movie detail');
    }
  }

  Future<ReviewItem> fetchReviews(int movieId) async {
    final response = await client.get('$_baseUrl'
        '/movie'
        '/$movieId'
        '/reviews'
        '?api_key=$_apiKey');
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ReviewItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to retrieve reviews');
    }
  }

  Future<Item> fetchSimilarMovies(int movieId) async {
    final response = await client.get('$_baseUrl'
        '/movie'
        '/$movieId'
        '/similar'
        '?api_key=$_apiKey');

    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error retrieving similar movies details');
    }
  }

  Future<GenreItem> fetchAllGenres() async {
    final response = await client.get('$_baseUrl'
        '/genre/movie/list'
        '?api_key=$_apiKey'
        '&language=en-US');
    if (response.statusCode == 200) {
      return GenreItem.fromJson(json.decode(response.body));
    } else {

      throw Exception('Error retrieving genres for the movies');
    }
  }

  String _buildDiscoverUrl(int discoverRequest, int page) {
    switch (discoverRequest) {
      case 1:
        return "$_baseUrl"
            "/movie/popular"
            "?api_key=$_apiKey"
            "&sort_by=popularity.desc"
            "&page=$page";
      case 2:
        return "$_baseUrl"
            "/movie"
            "/now_playing"
            "?api_key=$_apiKey"
            "&page=$page";
      case 3:
        return "$_baseUrl"
            "/movie"
            "/top_rated"
            "?api_key=$_apiKey"
            "&page=$page";
      case 4:
        return "$_baseUrl"
            "/movie"
            "/upcoming"
            "?api_key=$_apiKey"
            "&page=$page";
    }
  }
}
