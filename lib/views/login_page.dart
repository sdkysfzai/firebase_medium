import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todoapp/models/userModel.dart';
import 'package:firebase_todoapp/services/auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  String _message = "";
  Color _greenColor = Color(0xff00D959);
  final _formKey = GlobalKey<FormState>();
  bool _isLoggingIn = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    print("Login disposer called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 130, 150, 0),
                      child: Text(
                        "Hello \n There",
                        style: TextStyle(
                            fontSize: 55, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(155, 171, 0, 0),
                      child: Text(
                        ".",
                        style: TextStyle(
                            color: Colors.green[500],
                            fontSize: 80,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 64,
                ),
                LoginFormField(
                  labelText: "Email",
                  controller: _emailController,
                  validator: validateEmail,
                ),
                LoginFormField(
                  labelText: "Password",
                  controller: _passController,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 280,
                  child: _isLoggingIn
                      ? CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _greenColor,
                        )
                      : ElevatedButton(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 21),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            primary: _greenColor,
                          ),
                          onPressed: () async {
                            setState(() {
                              _isLoggingIn = true;
                              _message = '';
                            });
                            if (_formKey.currentState!.validate()) {
                              try {
                                await _auth.signInWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passController.text.trim());

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'HomePage', (route) => false);
                              } on FirebaseAuthException catch (e) {
                                switch (e.code) {
                                  case 'invalid-email':
                                    _message = 'Error: Incorrect Email!';
                                    break;
                                  case 'user-disabled':
                                    _message = 'Error: User disabled!';
                                    break;
                                  case 'user-not-found':
                                    _message = 'Error: User not found!';
                                    break;
                                  case 'wrong-password':
                                    _message = 'Error: Incorrect Password';
                                    break;
                                }
                              }
                            }
                            setState(() {
                              _isLoggingIn = false;
                            });
                          },
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Don't have an Account?"),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('RegisterScreen');
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: _greenColor),
                        ),
                      ),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    UserModel result = await _authService.singInAnnon();
                    print('user Signed in');
                    print("${result.uid}");
                  },
                  child: Text("Sign in Anonymously"),
                ),
              ],
            )),
      ),
    );
  }
}

class LoginFormField extends StatelessWidget {
  const LoginFormField({
    this.validator,
    Key? key,
    required this.labelText,
    TextEditingController? controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController? _controller;
  final String labelText;
  final validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: TextFormField(
        validator: validator,
        controller: _controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 1.5)),
            labelText: '$labelText',
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey[600])),
      ),
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'Email address cannot be empty!';
  }

  String pattern = r'\w+@\w+\.';
  RegExp regEx = RegExp(pattern);
  if (!regEx.hasMatch(formEmail)) return 'Invalid Email Address Format.';
  return null;
}
