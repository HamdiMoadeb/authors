import 'package:authers/models/post.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostLoadingState extends PostState {
  @override
  String toString() => 'PostLoadingState';
}

class PostInitialState extends PostState {
  @override
  String toString() => 'PostInitialState';
}

class PostLoadedState extends PostState {
  final List<Post> posts;
  PostLoadedState({this.posts});
}

class PostErrorState extends PostState {
  final error;
  PostErrorState({this.error});
}
