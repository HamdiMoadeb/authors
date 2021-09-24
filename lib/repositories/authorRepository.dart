import 'package:authers/models/author.dart';
import 'package:authers/repositories/author_api_client.dart';
import 'package:flutter/cupertino.dart';

class AuthorRepository {
  final AuthorApiClient authorApiClient;

  AuthorRepository({@required this.authorApiClient})
      : assert(authorApiClient != null);

  Future<List<Author>> fetchAuthors() async {
    return await authorApiClient.getAllAuthors();
  }
}