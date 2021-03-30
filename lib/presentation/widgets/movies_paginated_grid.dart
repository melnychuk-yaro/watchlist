import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../constatns.dart';
import '../../data/models/movie.dart';
import 'movie_card.dart';
import 'styled_text.dart';

class MoviesPaginatedGrid extends StatelessWidget {
  MoviesPaginatedGrid({
    required this.pagingController,
  });

  final PagingController<int, Movie> pagingController;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Movie>(
      pagingController: pagingController,
      padding: const EdgeInsets.all(4.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0,
        childAspectRatio: 0.75,
      ),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, movie, index) {
          return MovieCard(key: ValueKey(movie.id), movie: movie);
        },
        firstPageErrorIndicatorBuilder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledText(text: pagingController.error, icon: Icons.error),
              const SizedBox(height: kPadding / 2),
              ElevatedButton(
                onPressed: pagingController.refresh,
                child: Text('Try again'),
              ),
            ],
          );
        },
      ),
    );
  }
}
