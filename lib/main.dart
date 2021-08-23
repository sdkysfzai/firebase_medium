import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todoapp/data/onBoardingData.dart';
import 'package:firebase_todoapp/views/login_page.dart';
import 'package:firebase_todoapp/views/register_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Timer.periodic(Duration(seconds: 10), (Timer timer) {
        return setState(() {
          if (currentPage < 1) {
            currentPage++;
          } else {
            currentPage = 0;
          }
          pageController.animateToPage(
            currentPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        });
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase-Todo",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => OnBoardingWidget(pageController: pageController),
        'LoginScreen': (context) => LoginScreen(),
        'RegisterScreen': (context) => RegisterScreen(),
      },
    );
  }
}
