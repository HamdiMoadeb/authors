import 'package:authers/bloc/post/postBloc.dart';
import 'package:authers/bloc/post/postEvents.dart';
import 'package:authers/bloc/post/postState.dart';
import 'package:authers/models/author.dart';
import 'package:authers/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorDetailsPage extends StatefulWidget {
  Author author;
  AuthorDetailsPage({@required this.author});

  @override
  _AuthorDetailsPageState createState() => _AuthorDetailsPageState();
}

class _AuthorDetailsPageState extends State<AuthorDetailsPage> {
  loadPosts() async {
    context.read<PostBloc>().add(PostEvents.fetchPosts);
  }

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .3,
                width: double.infinity,
                color: Colors.teal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.author.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.author.userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.author.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .1),
              BlocBuilder<PostBloc, PostState>(
                  builder: (BuildContext context, PostState state) {
                if (state is PostErrorState) {
                  final error = state.error;
                  return Text(error.message);
                }
                if (state is PostLoadedState) {
                  List<Post> posts = state.posts;
                  return list(posts);
                }
                return Center(child: CircularProgressIndicator());
              }),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * .20,
            alignment: Alignment.topCenter,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .20),
            child: Center(
              child: CircleAvatar(
                radius: 74,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(widget.author.avatarUrl),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget list(List<Post> posts) {
    return Expanded(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (_, index) {
          Post post = posts[index];
          return Card(
            margin: EdgeInsets.all(5),
            child: ListTile(
              title: Text(post.title),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          );
        },
      ),
    );
  }
}
