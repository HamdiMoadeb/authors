import 'package:authers/bloc/author/authorBloc.dart';
import 'package:authers/bloc/author/authorEvents.dart';
import 'package:authers/bloc/author/authorState.dart';
import 'package:authers/models/author.dart';
import 'package:authers/views/authorDetailsPage.dart';
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

  toDetailsPage(Author author) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthorDetailsPage(
          author: author,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Best Authors'),
        centerTitle: true,
      ),
      body: Column(
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
              return list(authors);
            }
            return Center(child: CircularProgressIndicator());
          }),
        ],
      ),
    );
  }

  Widget list(List<Author> authors) {
    return Expanded(
      child: ListView.builder(
        itemCount: authors.length,
        itemBuilder: (_, index) {
          Author author = authors[index];
          return GestureDetector(
            onTap: () => toDetailsPage(authors[index]),
            child: Card(
              margin: EdgeInsets.all(5),
              child: ListTile(
                title: Text(author.name),
                subtitle: Text(author.email),
                trailing: Icon(Icons.keyboard_arrow_right_rounded),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    author.avatarUrl,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
