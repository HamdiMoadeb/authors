import 'package:authers/models/author.dart';
import 'package:equatable/equatable.dart';

class AuthorState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthorLoadingState extends AuthorState {
  @override
  String toString() => 'AuthorLoadingState';
}

class AuthorInitialState extends AuthorState {
  @override
  String toString() => 'AuthorInitialState';
}

class AuthorLoadedState extends AuthorState {
  final List<Author> authors;
  AuthorLoadedState({this.authors});
}

class AuthorErrorState extends AuthorState {
  final error;
  AuthorErrorState({this.error});
}
