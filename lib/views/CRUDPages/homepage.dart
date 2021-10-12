import 'package:flutter/material.dart';

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
                  // ignore: avoid_print
                  print("Drawer Clicked");
                  Navigator.of(context).pushNamed('DrawerScreen');
                },
                icon: const Icon(
                  Icons.drag_handle_outlined,
                  color: Colors.black,
                )),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: GestureDetector(
                onTap: () {
                  // ignore: avoid_print
                  print("Clicked");
                },
                child: const CircleAvatar(),
              ),
            ),
          ],
        ),
      ),
      body: const HomeBody(),
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
      ],
    );
  }
}
