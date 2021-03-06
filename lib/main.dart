import 'package:authers/bloc/author/authorBloc.dart';
import 'package:authers/repositories/authorApiClient.dart';
import 'package:authers/repositories/authorRepository.dart';
import 'package:authers/utils/appData.dart';
import 'package:authers/views/authorsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: BlocProvider(
          create: (context) => AuthorBloc(
              authorRepository:
                  AuthorRepository(authorApiClient: AuthorApiClient())),
          //AuthorBloc(),
          child: AuthorsPage(),
        ),
      ),
    );
  }
}
