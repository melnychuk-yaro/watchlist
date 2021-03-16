import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/business_logic/bloc/search_bloc.dart';
import 'package:watchlist/presentation/widgets/search-grid.dart';

class Search extends StatefulWidget {
  final PageStorageKey key;
  Search({required this.key});

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
          padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 4.0),
          child: TextField(
            controller: _searchQuery,
            decoration: InputDecoration(hintText: 'Search'),
          ),
        ),
        Expanded(child: SearchGrid()),
      ],
    );
  }
}
