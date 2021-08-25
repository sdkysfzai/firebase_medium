import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/handimage.jpg'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 240, left: 30),
              child: Row(
                children: const [
                    Text(
                    "reader",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                  ),
                    Text(
                    "mind",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Explore digital stories.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
