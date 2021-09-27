import 'dart:convert';

import 'package:authers/models/author.dart';
import 'package:authers/utils/constants.dart';
import 'package:http/http.dart' as http;

class AuthorApiClient {
  Future<List<Author>> getAllAuthors() async {
    List<Author> authors = [];

    var url = Uri.parse('${Constants.BASE_URL}/authors');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      for (Map athr in body) {
        authors.add(Author.fromJson(athr));
      }
    } else {
      print('${response.body}');
      throw Exception('error getting authors');
    }

    return authors;
  }
}
