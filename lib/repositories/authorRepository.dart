import 'package:authers/models/author.dart';
import 'package:authers/repositories/authorApiClient.dart';
import 'package:flutter/cupertino.dart';

class AuthorRepository {
  final AuthorApiClient authorApiClient;

  AuthorRepository({@required this.authorApiClient});

  Future<List<Author>> fetchAuthors() async {
    return await authorApiClient.getAllAuthors();
  }
}
