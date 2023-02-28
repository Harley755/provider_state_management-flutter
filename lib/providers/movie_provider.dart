import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:provider_state_management/models/movie_model.dart';

final List<Movie> initialData = List.generate(
  50,
  (index) => Movie(
    title: "Movie $index",
    duration: "${Random().nextInt(100) + 60}",
  ),
);

class MovieProvider extends ChangeNotifier {
  final List<Movie> _movies = initialData;
  List<Movie> get movies => _movies;

  final List<Movie> _myList = [];
  List<Movie> get myList => _myList;

  void addToList(Movie movie) {
    _myList.add(movie);
    notifyListeners();
  }

  void removeFromList(Movie movie) {
    _myList.remove(movie);
    notifyListeners();
  }

  Stream<int> addDuration(List<Movie> myListDuration) async* {
    await Future.delayed(const Duration(seconds: 1));
    List<int> duration = [];
    int totalDuration = 0;
    for (var i = 0; i < myListDuration.length; i++) {
      duration.add(int.parse(myListDuration[i].duration.toString()));
    }
    for (var i = 0; i < duration.length; i++) {
      totalDuration += duration[i];
    }
    yield totalDuration;
  }
}
