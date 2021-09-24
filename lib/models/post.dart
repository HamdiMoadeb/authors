import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String date;
  final String title;
  final String body;
  final String imageUrl;
  final int authorId;

  const Post(
      {this.id,
      this.date,
      this.title,
      this.body,
      this.imageUrl,
      this.authorId});

  @override
  List<Object> get props => [id, date, title, body, imageUrl, authorId];

  static Post fromJson(dynamic json) {
    return Post(
      id: json['_id'],
      date: json['date'],
      title: json['title'],
      body: json['body'],
      imageUrl: json['imageUrl'],
      authorId: json['authorId'],
    );
  }

  @override
  String toString() => 'Post { id: $id}';
}
