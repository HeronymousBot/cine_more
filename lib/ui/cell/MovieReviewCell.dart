import 'package:cinemore/model/Review.dart';
import 'package:flutter/material.dart';

class MovieReviewCell extends StatelessWidget {
  Review review;

  MovieReviewCell(this.review);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Card(
        elevation: 0.6,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                review.content.length > 300
                    ? review.content.substring(0, 300) + '...'
                    : review.content,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.bottomRight,
              child: Text('- ' + review.author),
            ),
          ],
        ),
      ),
    );
  }
}
