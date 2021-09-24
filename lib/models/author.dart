import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final int id;
  final String name;
  final String userName;
  final String email;
  final String avatarUrl;

  const Author({this.id, this.name, this.userName, this.email, this.avatarUrl});

  @override
  List<Object> get props => [id, name, userName, email, avatarUrl];

  static Author fromJson(dynamic json) {
    return Author(
      id: json['_id'],
      name: json['name'],
      userName: json['userName'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
    );
  }

  @override
  String toString() => 'Author { id: $id}';
}
