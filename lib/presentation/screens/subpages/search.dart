import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../business_logic/bloc/search_bloc.dart';
import '../../../constatns.dart';
import '../../widgets/search_grid.dart';

class Search extends StatefulWidget {
  final PageStorageKey key;
  const Search({required this.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _searchQuery;
  late SearchBloc _bloc;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<SearchBloc>();
    _searchQuery = TextEditingController(text: _bloc.state.query);
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _bloc.add(SearchLoadEvent(_searchQuery.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            kPadding / 2,
            kPadding / 2,
            kPadding / 2,
            kPadding / 4,
          ),
          child: TextField(
            controller: _searchQuery,
            decoration: InputDecoration(
              prefixIcon: Padding(
                child: Icon(Icons.search, color: Theme.of(context).hintColor),
                padding: const EdgeInsets.only(left: kPadding, right: 10),
              ),
              hintText: AppLocalizations.of(context)!.search,
            ),
          ),
        ),
        Expanded(child: SearchGrid()),
      ],
    );
  }
}
