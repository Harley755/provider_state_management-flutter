import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_management/providers/movie_provider.dart';

class FavMovies extends StatefulWidget {
  const FavMovies({super.key});

  @override
  State<FavMovies> createState() => _FavMoviesState();
}

class _FavMoviesState extends State<FavMovies> {
  @override
  Widget build(BuildContext context) {
    final myList = context.watch<MovieProvider>().myList;
    return Scaffold(
      appBar: AppBar(
        title: Text("My favorite Movies (${myList.length})"),
      ),
      body: ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context, index) {
          final currentFavoriteMovie = myList[index];
          return Card(
            key: ValueKey(currentFavoriteMovie.title),
            elevation: 4,
            child: ListTile(
              title: Text(currentFavoriteMovie.title),
              subtitle: Text(currentFavoriteMovie.duration ?? ''),
              trailing: TextButton(
                onPressed: () {
                  context
                      .read<MovieProvider>()
                      .removeFromList(currentFavoriteMovie);
                },
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
