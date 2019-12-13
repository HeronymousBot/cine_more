import 'Genre.dart';

class GenreItem{

  List<Genre> genres = [];

  GenreItem.fromJson(Map<String, dynamic> json){

    List<Genre> temp = [];
    for (int i = 0; i < json['genres'].length; i++) {
      Genre review = Genre(json['genres'][i]);
      temp.add(review);
    }
    genres = temp;
  }


}