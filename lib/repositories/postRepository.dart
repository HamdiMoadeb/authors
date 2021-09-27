import 'package:authers/models/post.dart';
import 'package:authers/repositories/postApiClient.dart';
import 'package:flutter/cupertino.dart';

class PostRepository {
  final PostApiClient postApiClient;
  final String authorId;
  final BuildContext context;

  PostRepository(
      {@required this.postApiClient, @required this.authorId, this.context});

  Future<List<Post>> fetchPosts() async {
    return await postApiClient.getAllPosts(authorId, context);
  }
}
