import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todoapp/data/onBoardingData.dart';
import 'package:firebase_todoapp/views/CRUDPages/homepage.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase-Todo",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => OnBoardingWidget(),
        'LoginScreen': (context) => LoginScreen(),
        'RegisterScreen': (context) => RegisterScreen(),
        'HomePage' : (context) => HomePage(),
      },
    );
  }
}//
