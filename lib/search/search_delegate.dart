import 'package:app_movies/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search Movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => {close(context, null)},
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildActions');
  }

  Widget _emptyContainer() {
    return const Center(
      child:
          Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);

    moviesProvider.getSuggestionByQuery(query);

    return StreamBuilder(
        builder: (_, AsyncSnapshot<List<Movie>> snapShot) {
          if (!snapShot.hasData) return _emptyContainer();

          final movies = snapShot.data!;
          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (_, int index) =>
                  _MovieSuggestionItem(movies[index]));
        },
        stream: moviesProvider.suggestionStream);
  }
}

class _MovieSuggestionItem extends StatelessWidget {
  final Movie movie;

  const _MovieSuggestionItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPorterImg),
          width: 80,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
