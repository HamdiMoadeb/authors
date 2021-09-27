import 'dart:convert';

import 'package:authers/models/post.dart';
import 'package:authers/utils/constants.dart';
import 'package:http/http.dart' as http;

class PostApiClient {
  Future<List<Post>> getAllPosts(String authorId, String page) async {
    List<Post> posts = [];

    var url =
        Uri.parse('${Constants.BASE_URL}/posts?authorId=$authorId&_page=$page');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (Map pst in body) {
        posts.add(Post.fromJson(pst));
      }
    } else {
      print('${response.body}');
      throw Exception('error getting posts');
    }

    return posts;
  }
}
