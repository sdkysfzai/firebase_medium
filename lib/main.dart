import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todoapp/data/on_boarding_data.dart';
import 'package:firebase_todoapp/services/auth.dart';
import 'package:firebase_todoapp/views/CRUDPages/create_post.dart';
import 'package:firebase_todoapp/views/CRUDPages/homepage.dart';
import 'package:firebase_todoapp/views/appbar_pages/drawer.dart';
import 'package:firebase_todoapp/views/login_page.dart';
import 'package:firebase_todoapp/views/register_page.dart';
import 'package:firebase_todoapp/views/settings.dart/myacc_settings.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return MaterialApp(
      title: "Firebase-Todo",
      debugShowCheckedModeBanner: false,
      home: _auth.user == null ? const OnBoardingWidget() : const HomePage(),
      routes: {
        'HomePage': (context) => const HomePage(),
        'OnBoardingWidget': (context) => const OnBoardingWidget(),
        'LoginScreen': (context) => const LoginScreen(),
        'RegisterScreen': (context) => const RegisterScreen(),
        'DrawerScreen': (context) => const DrawerScreen(),
        'CreatePostScreen': (context) => const CreatePost(),
        'MyAccSettingScreen': (context) => const AccountSettings(),
      },
    );
  }
}//
