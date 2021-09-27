import 'dart:io';

import 'package:authers/bloc/post/postEvents.dart';
import 'package:authers/bloc/post/postState.dart';
import 'package:authers/models/post.dart';
import 'package:authers/repositories/postRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvents, PostState> {
  PostRepository postRepository;
  List<Post> postsList = [];

  PostBloc({@required this.postRepository}) : super(PostInitialState());

  @override
  Stream<PostState> mapEventToState(PostEvents event) async* {
    if (event == PostEvents.fetchPosts) {
      yield PostLoadingState();
      try {
        postsList = await postRepository.fetchPosts();
        yield PostLoadedState(posts: postsList);
      } on SocketException {
        yield PostErrorState(error: 'No Internet');
      } on HttpException {
        yield PostErrorState(error: 'No Service');
      } on FormatException {
        yield PostErrorState(error: 'Format Exception');
      } catch (e) {
        yield PostErrorState(error: 'Exception : ' + e.toString());
      }
    }
  }

  @override
  Stream<PostState> onError(Object error, StackTrace stackTrace) async* {
    super.onError(error, stackTrace);
    yield PostErrorState(error: 'onError: ' + error.toString());
  }
}
