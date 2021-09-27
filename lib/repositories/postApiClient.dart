import 'dart:convert';

import 'package:authers/models/post.dart';
import 'package:authers/models/postsPagination.dart';
import 'package:authers/utils/appData.dart';
import 'package:authers/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PostApiClient {
  Future<List<Post>> getAllPosts(String authorId, context) async {
    List<Post> posts = [];
    String page = '${Provider.of<AppData>(context, listen: false).currentPage}';

    var url =
        Uri.parse('${Constants.BASE_URL}/posts?authorId=$authorId&_page=$page');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      savePaginationData(response.headers, page, context);

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

  savePaginationData(Map<String, String> headers, String currentPage, context) {
    String lastString = headers['link']
        .split(',')
        .singleWhere((element) => element.contains('rel="last"'));

    String firstString = headers['link']
        .split(',')
        .singleWhere((element) => element.contains('rel="first"'));

    String lastNb = lastString.substring(
        lastString.lastIndexOf('_page=') + 6, lastString.lastIndexOf('>'));

    String firstNb = firstString.substring(
        firstString.lastIndexOf('_page=') + 6, firstString.lastIndexOf('>'));

    bool canNext = int.parse(lastNb) > int.parse(currentPage) ? true : false;
    bool canPrev = int.parse(firstNb) < int.parse(currentPage) ? true : false;

    PostPagination pagination = PostPagination(canNext, canPrev);

    Provider.of<AppData>(context, listen: false).updatePagination(pagination);
  }
}
