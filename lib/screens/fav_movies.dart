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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  final currentFavoriteMovie = myList[index];
                  return Card(
                    key: ValueKey(currentFavoriteMovie.title),
                    elevation: 4,
                    child: ListTile(
                      title: Text(currentFavoriteMovie.title),
                      subtitle: Text(
                        "${currentFavoriteMovie.duration ?? 'No infomations'} minutes",
                      ),
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
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      "Total de minute",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    StreamBuilder<int>(
                      stream: context.read<MovieProvider>().addDuration(myList),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text(
                            "${snapshot.data}",
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.blue),
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
