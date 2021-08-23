import 'package:firebase_todoapp/views/OnBoardingPages/firstpage.dart';
import 'package:firebase_todoapp/views/OnBoardingPages/secondpage.dart';
import 'package:flutter/material.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          allowImplicitScrolling: true,
          controller: pageController,
          children: [
            FirstPage(),
            SecondPage(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0)
                      ]),
                  child: ElevatedButton(
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('RegisterScreen');
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          decoration: TextDecoration.none),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'LoginScreen');
                        },
                        child: Text("Sign in")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
