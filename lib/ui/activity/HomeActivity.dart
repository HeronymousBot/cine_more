
import 'package:cinemore/ui/fragment/DiscoverFragment.dart';
import 'package:cinemore/ui/fragment/FavoritesFragment.dart';
import 'package:cinemore/ui/fragment/SearchFragment.dart';
import 'package:flutter/material.dart';

class HomeActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeActivityState();
  }
}

class HomeActivityState extends State<HomeActivity> {
  List<Widget> _fragments = [];
  int _currentIndex = 0;

  @override
  void initState() {
    _fragments = [DiscoverFragment(), SearchFragment(), FavoritesFragment()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _fragments[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.pinkAccent,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text('Discover'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
