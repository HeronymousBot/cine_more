import 'package:cinemore/model/Review.dart';

class ReviewItem{
  int page;
  int id;
  List<Review> reviews = [];

  ReviewItem.fromJson(Map<String, dynamic> json){
    id = json['id'];
    page = json['page'];
    List<Review> temp = [];
    for (int i = 0; i < json['results'].length; i++) {
      Review review = Review(json['results'][i]);
      temp.add(review);
    }
    reviews = temp;
  }


}