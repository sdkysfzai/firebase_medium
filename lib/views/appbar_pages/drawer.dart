import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          children: const [
            Text(
              'reader',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              'mind',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 25),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: const DrawerItems(),
    );
  }
}

class DrawerItems extends StatefulWidget {
  const DrawerItems({Key? key}) : super(key: key);

  @override
  _DrawerItemsState createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text(
              'Home',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text(
              'Articles',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text(
              'Browse',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text(
              'Interests',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text(
              'Help',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 40,
          ),
          const Divider(
            thickness: 0.8,
            color: Colors.black,
            height: 20,
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            child: const Text(
              'My Account',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text(
              'Settings',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text(
              'Sign Out',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
