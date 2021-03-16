import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class User extends Equatable {
  const User({
    required this.email,
    required this.id,
    this.name,
    this.photo,
  });

  final String email;
  final String id;
  final String? name;
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(email: '', id: '', name: null, photo: null);

  @override
  List<Object> get props => [email, id];
}
