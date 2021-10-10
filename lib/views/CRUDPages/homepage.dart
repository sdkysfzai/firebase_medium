import 'package:firebase_todoapp/models/user_model.dart';
import 'package:firebase_todoapp/services/auth.dart';
import 'package:firebase_todoapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print("Home page called");
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return StreamProvider<List<UserModel>>.value(
      value: DatabaseService().userData,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.of(context).pushReplacementNamed("OnBoardingWidget");
              },
              child: const Text("Sign out"),
            )
          ],
        ),
        body: const PostList(),
      ),
    );
  }
}

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final users = context.read<List<UserModel>?>() ?? [];
    // ignore: avoid_function_literals_in_foreach_calls
    users.forEach((doc) {
      // ignore: avoid_print
      print(doc.email);
      // ignore: avoid_print
      print(doc.username);
    });

    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final UserModel user = users[index];
          // ignore: avoid_print
          return Card(
            child: Center(
              child: ListTile(
                leading: const CircleAvatar(backgroundColor: Colors.brown),
                title: Text(user.username),
                subtitle: Text(user.email),
              ),
            ),
          );
        });
  }
}
