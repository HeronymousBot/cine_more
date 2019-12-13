import 'package:cinemore/model/Result.dart';

class Item {
  int page;
  int totalResults;
  int totalPages;
  List<Result> results = [];

  Item.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    page = parsedJson['page'];
    totalResults = parsedJson['total_results'];
    totalPages = parsedJson['total_pages'];
    List<Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Result result = Result(parsedJson['results'][i]);
      temp.add(result);
    }
    results = temp;
  }
}
