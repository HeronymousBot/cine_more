class Review {
  String id;
  String author;
  String content;

  Review(dynamic review) {
    id = review['id'];
    author = review['author'];
    content = review['content'];
  }
}
