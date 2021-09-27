import 'package:authers/models/post.dart';
import 'package:authers/repositories/postApiClient.dart';
import 'package:flutter/cupertino.dart';

class PostRepository {
  final PostApiClient postApiClient;
  final String authorId;
  final String page;

  PostRepository(
      {@required this.postApiClient,
      @required this.authorId,
      @required this.page});

  Future<List<Post>> fetchPosts() async {
    return await postApiClient.getAllPosts(authorId, page);
  }
}
