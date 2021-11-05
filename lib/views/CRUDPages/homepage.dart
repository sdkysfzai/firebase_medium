import 'package:firebase_todoapp/models/post_model.dart';
import 'package:firebase_todoapp/services/database.dart';
import 'package:firebase_todoapp/views/CRUDPages/delete_post.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.1,
          leading: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: IconButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                iconSize: 47,
                onPressed: () {
                  Navigator.of(context).pushNamed('DrawerScreen');
                },
                icon: const Icon(
                  Icons.drag_handle_outlined,
                  color: Colors.black,
                )),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 23, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('MyAccSettingScreen');
                },
                child: const CircleAvatar(),
              ),
            ),
          ],
        ),
      ),
      body: const HomeBody(),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 9,
              offset: const Offset(3, 5),
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 0,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.of(context).pushNamed('CreatePostScreen');
          },
          child: const Icon(Icons.add),
          backgroundColor: const Color(0xff00D959),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Posts>>(
      initialData: const [],
      create: (context) => DatabaseService().userPosts,
      child: const PostList(),
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
    final posts = context.watch<List<Posts>?>() ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Text(
            'Blogs',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Search Blogs',
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final Posts post = posts[index];

                return Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          post.photo,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                                'https://via.placeholder.com/350x150');
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          post.description,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => const DeletePost(),
                          child: const Text('Delete Post'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
