import 'package:cinemore/api/MovieController.dart';
import 'package:cinemore/model/Genre.dart';
import 'package:cinemore/model/Result.dart';
import 'package:cinemore/ui/cell/ResultCell.dart';
import 'package:flutter/material.dart';

class SearchFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchFragmentState();
  }
}

class SearchFragmentState extends State<SearchFragment> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  bool isLoading;
  List<Result> moviesList;
  List<Genre> genresList;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    _getGenres();
    moviesList = List<Result>();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.grey[800],
          ),
          backgroundColor: Colors.white,
          expandedHeight: 120,
          elevation: 3,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.pink,
              onPressed: () {
                setState(() {
                  isLoading = true;
                  _getSearchResults(searchController.text);
                });
              },
            )
          ],
          flexibleSpace: Container(
            height: 48,
            padding: EdgeInsets.symmetric(vertical: 16),
            margin: EdgeInsets.symmetric(vertical: 48.0, horizontal: 12),
            child: TextFormField(
              textInputAction: TextInputAction.search,
              focusNode: searchFocusNode,
              onFieldSubmitted: (value) {
                setState(() {
                  isLoading = true;
                  _getSearchResults(searchController.text);
                  searchFocusNode.unfocus();
                });
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
              ),
            ),
          ),
        ),

        moviesList.length != null
            ? SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ResultCell(moviesList[index], context,view: "discover", genres: genresList,);
                }, childCount: moviesList.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 4.0,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4),
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
    );
  }

  void _getSearchResults(String query) {
    MovieController().fetchSearchResults(query).then((data) {
      setState(() {
        moviesList = null;
        moviesList = data.results;
        isLoading = false;
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
