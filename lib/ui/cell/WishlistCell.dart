import 'package:cinemore/model/Movie.dart';
import 'package:cinemore/ui/cell/MovieCell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistCell extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WishlistCellState();
  }
}

class WishlistCellState extends State<WishlistCell> {
  String userToken;
  List<Movie> moviesList;
  @override
  void initState() {
    super.initState();
    _getUserToken();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(userToken)
          .collection('wishlist')
          .snapshots(),
      builder: (context, snapshot) {
        moviesList = snapshot.data?.documents?.map((documentSnapshot) => Movie.fromFirebase(documentSnapshot.data))?.toList() ?? List<Movie>();
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {

              return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: index == 0 ? 24 : 12,
                      vertical: 16),
                  child:
                  MovieCell(moviesList[index], context));
            },
            itemCount: moviesList?.length ?? 0,
          ),
        );
      },
    );
  }

  void _getUserToken() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        userToken = prefs.get('userToken');
      });

    });
  }
}
