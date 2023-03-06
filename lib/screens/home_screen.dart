import '../search/search_delegate.dart';
import 'package:app_movies/providers/providers.dart';
import 'package:app_movies/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Va al arbol de Widgets y extrae el tipo MovieProvider
    final moviesProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movies in theaters'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(
              movies: moviesProvider.onDisplayMovies,
            ),
            // Listado de peliculas
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Popular',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        ),
      ),
    );
  }
}
