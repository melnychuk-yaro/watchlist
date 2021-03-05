part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchLoadEvent extends SearchEvent {
  final String query;
  SearchLoadEvent(this.query);
}

class SearchNextPageLoadEvent extends SearchEvent {}

class SearchResetEvent extends SearchEvent {}
