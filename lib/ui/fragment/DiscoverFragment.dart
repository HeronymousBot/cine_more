import 'package:cinemore/api/MovieController.dart';
import 'package:cinemore/model/Genre.dart';
import 'package:cinemore/model/Result.dart';
import 'package:cinemore/ui/cell/ResultCell.dart';
import 'package:flutter/material.dart';

class DiscoverFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DiscoverFragmentState();
  }
}

class DiscoverFragmentState extends State<DiscoverFragment> {
  List<Result> moviesList;
  List<Genre> genresList;
  int _discoverRequest;
  int page;
  String discoverTitle;
  ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
    page = 1;
    moviesList = List<Result>();
    _discoverRequest = 1;
    discoverTitle = 'Most Popular';
    _getGenres();
    _getMovies(_discoverRequest, page);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        page += 1;
        _getMovies(_discoverRequest, page);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.grey[800]),
            expandedHeight: 96,
            title: Text(
              discoverTitle,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              PopupMenuButton<int>(
                onSelected: (int discoverRequest) {
                  setState(() {
                    moviesList = List<Result>();
                    page = 1;
                    _getMovies(discoverRequest, page);
                    switch (discoverRequest) {
                      case 1:
                        discoverTitle = 'Most Popular';
                        _discoverRequest = 1;
                        break;
                      case 2:
                        discoverTitle = 'Now Playing';
                        _discoverRequest = 2;
                        break;
                      case 3:
                        discoverTitle = 'Top Rated';
                        _discoverRequest = 3;
                        break;
                      case 4:
                        discoverTitle = 'Upcoming';
                        _discoverRequest = 4;
                        break;
                    }
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text('Most Popular'),
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text('Now Playing'),
                  ),
                  const PopupMenuItem<int>(
                    value: 3,
                    child: Text('Top Rated'),
                  ),
                  const PopupMenuItem<int>(
                    value: 4,
                    child: Text('Upcoming'),
                  )
                ],
              )
            ],
          ),
          moviesList.length != 0 ||moviesList == null && genresList.length != 0 || genresList == null
              ? SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ResultCell(moviesList[index], context, view: "discover", genres: genresList,);
                  }, childCount: moviesList.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 4.0,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 8),
                )
              : SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 140,
                    ),
                    Align(
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    )
                  ]),
                )
        ],
      ),
    );
  }

  void _getMovies(int discoverRequest, int page) {
    MovieController().fetchMovieList(discoverRequest, page).then((response) {
      setState(() {
        moviesList += response.results;
      });
    });
  }

  void _getGenres(){
    MovieController().fetchAllGenres().then((genreItem){
      setState(() {
        genresList = genreItem.genres;
      });
    });
  }
}
