import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const Expanded(
              flex: 1,
              child:  Image(
                image: AssetImage("assets/images/secondimage.jpg"),
              ),
            ),
            Expanded(
                flex: 1,
                child: Stack(
                  children:  [
                    Container(
                      color: Colors.white,
                    ),
                    Padding(
                      padding:  const EdgeInsets.only(left: 30, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Get Started",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Publish Your Passion in Own Way \nIt's free",
                            style: TextStyle(
                                fontSize: 38, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
