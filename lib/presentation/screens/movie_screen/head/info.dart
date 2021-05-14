import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/models/movie_detailed.dart';
import 'info_item.dart';

class Info extends StatelessWidget {
  Info({Key? key, required this.movie}) : super(key: key);

  final MovieDetailed movie;
  final budgetFormat = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InfoItem(
          defenition: AppLocalizations.of(context)!.rating,
          value: movie.rating.toString(),
        ),
        const SizedBox(height: 4.0),
        InfoItem(
          defenition: AppLocalizations.of(context)!.release_date,
          value: movie.releaseDate,
        ),
        const SizedBox(height: 4.0),
        movie.budget == 0
            ? InfoItem(
                defenition: AppLocalizations.of(context)!.budget, value: '-')
            : InfoItem(
                defenition: AppLocalizations.of(context)!.budget,
                value: budgetFormat.format(movie.budget),
              ),
        const SizedBox(height: 4.0),
        InfoItem(
          defenition: AppLocalizations.of(context)!.director,
          value: movie.directors.join(', '),
        ),
      ],
    );
  }
}
