import 'package:authers/bloc/author/authorBlock.dart';
import 'package:authers/bloc/author/authorEvents.dart';
import 'package:authers/bloc/author/authorState.dart';
import 'package:authers/models/author.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorsPage extends StatefulWidget {
  @override
  _AuthorsPageState createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> {
  @override
  void initState() {
    super.initState();
    loadAuthors();
  }

  loadAuthors() async {
    context.read<AuthorBloc>().add(AuthorEvents.fetchAuthors);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<AuthorBloc, AuthorState>(
            builder: (BuildContext context, AuthorState state) {
          if (state is AuthorErrorState) {
            final error = state.error;
            return Text(error.message);
          }
          if (state is AuthorLoadedState) {
            List<Author> authors = state.authors;
            return _list(authors);
          }
          return Center(child: CircularProgressIndicator());
        }),
      ],
    );
  }

  Widget _list(List<Author> authors) {
    return Expanded(
      child: ListView.builder(
        itemCount: authors.length,
        itemBuilder: (_, index) {
          Author author = authors[index];
          return Text(author.name);
        },
      ),
    );
  }
}
