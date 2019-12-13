import 'package:cinemore/model/Movie.dart';
import 'package:cinemore/provider/SessionManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseManager {
  FirebaseManager._internal();

  static final FirebaseManager _singleton = FirebaseManager._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _databaseReference = Firestore.instance;
  static String userToken;

  factory FirebaseManager() {
    return _singleton;
  }

  Future<bool> createUser(
      String userEmail, String userPassword, String userName) async {
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );

    if (user != null) {
      _databaseReference
          .collection('users')
          .document(user.uid)
          .setData({'name': userName});
      SessionManager.store(user.uid);
      userToken = user.uid;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLogged() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user != null ? true : false;
  }

  Future<void> handleSignOut() async {
    SessionManager.clear();
    await _auth.signOut();
  }

  Future<bool> handleSignIn(String userEmail, String userPassword) async {
    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );

    if (user != null) {
      SessionManager.store(user.uid);
      userToken = user.uid;
      return true;
    } else {
      return false;
    }
  }

  Future<void> addToFavorites(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('userToken');

    DocumentReference newFavorite = _databaseReference
        .collection('users')
        .document(token)
        .collection('favorites')
        .document('${movie.id}');

    await newFavorite.setData(movie.toFirebase());
  }

  Future<void> deleteFromFavorites(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('userToken');
    await _databaseReference
        .collection('users')
        .document(token)
        .collection('favorites')
        .document('${movie.id}')
        .delete();
  }

  Future<bool> checkIfInWishlist(int movieId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DocumentReference documentReference = _databaseReference
        .collection('users')
        .document(prefs.get('userToken'))
        .collection('wishlist')
        .document('$movieId');
    DocumentSnapshot documentSnapshot = await documentReference.get();
    return documentSnapshot.exists;
  }

  Future<bool> checkIfInFavorites(int movieId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DocumentReference documentReference = _databaseReference
        .collection('users')
        .document(prefs.get('userToken'))
        .collection('favorites')
        .document('$movieId');
    DocumentSnapshot documentSnapshot = await documentReference.get();
    return documentSnapshot.exists;
  }
  Future<bool> checkFavoritesCollection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CollectionReference collectionReference = _databaseReference
        .collection('users')
        .document(prefs.get('userToken'))
        .collection('favorites');
    QuerySnapshot querySnapshot = await collectionReference.getDocuments();
    return querySnapshot.documents.isNotEmpty;
  }

  Future<bool> checkWishlistCollection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CollectionReference collectionReference = _databaseReference
        .collection('users')
        .document(prefs.get('userToken'))
        .collection('wishlist');
    QuerySnapshot querySnapshot = await collectionReference.getDocuments();
    return querySnapshot.documents.isNotEmpty;
  }


  Future<void> addToWishlist(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('userToken');
    DocumentReference newFavorite = _databaseReference
        .collection('users')
        .document(token)
        .collection('wishlist')
        .document('${movie.id}');

    await newFavorite.setData(movie.toFirebase());
  }

  Future<void> deleteFromWishlist(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('userToken');
    await _databaseReference
        .collection('users')
        .document(token)
        .collection('wishlist')
        .document('${movie.id}')
        .delete();
  }
}
