import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/presentation/widgets/movie-card.dart';

class MoviesPaginatedGrid extends StatelessWidget {
  const MoviesPaginatedGrid({
    Key key,
    @required PagingController<int, Movie> pagingController,
  })  : _pagingController = pagingController,
        super(key: key);

  final PagingController<int, Movie> _pagingController;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Movie>(
      pagingController: _pagingController,
      padding: const EdgeInsets.all(4.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0,
        childAspectRatio: 0.75,
      ),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, movie, index) {
          return MovieCard(movie: movie);
        },
      ),
    );
  }
}
