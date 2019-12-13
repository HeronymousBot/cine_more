import 'package:cinemore/provider/FirebaseManager.dart';
import 'package:cinemore/provider/SessionManager.dart';
import 'package:cinemore/ui/activity/StartActivity.dart';
import 'package:cinemore/ui/cell/FavoritesCell.dart';
import 'package:cinemore/ui/cell/WishlistCell.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoritesFragmentState();
  }
}

class FavoritesFragmentState extends State<FavoritesFragment> {
  String userToken;
  bool hasFavoritesList;
  bool hasWishlist;

  @override
  void initState() {
    super.initState();
    _getUserToken();
    _hasFavoritesList();
    _hasWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.grey[800],
            onPressed: () async {
              await FirebaseManager().handleSignOut();
              await SessionManager.clear();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => StartActivity()));
            },
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 24, top: 48),
            child: Text(
              'Wish to see',
              style: TextStyle(fontSize: 24, color: Colors.grey[800]),
            ),
          ),
          hasWishlist != null ? WishlistCell() : SizedBox.shrink(),
          Container(
            margin: EdgeInsets.only(left: 24),
            child: Text('Favorites',
                style: TextStyle(fontSize: 24, color: Colors.grey[800])),
          ),
          hasFavoritesList != null ? FavoritesCell() : SizedBox.shrink(),
        ],
      ),
    );
  }

  void _getUserToken() {
    SharedPreferences.getInstance().then((prefs) {
      userToken = prefs.get('userToken');
    });
  }

  void _hasFavoritesList() {
    FirebaseManager().checkFavoritesCollection().then((hasFavorites) {
      setState(() {
        hasFavoritesList = hasFavorites;
      });
    });
  }

  void _hasWishlist() {
    FirebaseManager().checkWishlistCollection().then((hasAWishlist) {
      setState(() {
        hasWishlist = hasAWishlist;
      });
    });
  }
}
