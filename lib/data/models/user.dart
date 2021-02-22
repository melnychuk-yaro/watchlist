import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo,
  })  : assert(email != null),
        assert(id != null);

  final String email;
  final String id;
  final String name;
  final String photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(email: '', id: '', name: null, photo: null);
}
