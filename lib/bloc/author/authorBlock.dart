import 'dart:io';

import 'package:authers/bloc/author/authorEvents.dart';
import 'package:authers/bloc/author/authorState.dart';
import 'package:authers/models/author.dart';
import 'package:authers/repositories/authorRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorBloc extends Bloc<AuthorEvents, AuthorState> {
  AuthorRepository authorRepository;
  List<Author> authorsList = [];

  AuthorBloc({@required this.authorRepository}) : super(AuthorInitialState());

  @override
  Stream<AuthorState> mapEventToState(AuthorEvents event) async* {
    if (event == AuthorEvents.fetchAuthors) {
      yield AuthorLoadingState();
      try {
        authorsList = await authorRepository.fetchAuthors();
        yield AuthorLoadedState(authors: authorsList);
      } on SocketException {
        yield AuthorErrorState(error: 'No Internet');
      } on HttpException {
        yield AuthorErrorState(error: 'No Service');
      } on FormatException {
        yield AuthorErrorState(error: 'Format Exception');
      } catch (e) {
        yield AuthorErrorState(error: 'Exception : ' + e.toString());
      }
    }
  }

  @override
  Stream<AuthorState> onError(Object error, StackTrace stackTrace) async* {
    super.onError(error, stackTrace);
    yield AuthorErrorState(error: 'onError: ' + error.toString());
  }
}
