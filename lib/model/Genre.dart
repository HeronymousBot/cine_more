class Genre {
  int id;
  String name;

  Genre(dynamic genre) {
    id = genre["id"];
    name = genre["name"];
  }
}
