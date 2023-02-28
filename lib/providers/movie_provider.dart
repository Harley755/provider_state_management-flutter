import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:provider_state_management/models/movie_model.dart';

final List<Movie> initialData = List.generate(
  50,
  (index) => Movie(
    title: "Movie $index+1",
    duration: "${Random().nextInt(100) + 60} minutes",
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
}
