import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todoapp/models/user_model.dart';
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
  final Color _greenColor = const Color(0xff00D959);
  final _formKey = GlobalKey<FormState>();
  bool _isLoggingIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    // ignore: avoid_print
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
                      padding: const EdgeInsets.fromLTRB(0, 130, 150, 0),
                      child: const Text(
                        "Hello \n There",
                        style: TextStyle(
                            fontSize: 55, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(155, 171, 0, 0),
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
                const SizedBox(
                  height: 64,
                ),
                LoginFormField(
                  labelText: "Email",
                  controller: _emailController,
                  obscureText: false,
                  validator: validateEmail,
                ),
                LoginFormField(
                  labelText: "Password",
                  obscureText: true,
                  controller: _passController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: _isLoggingIn
                      ? CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _greenColor,
                        )
                      : ElevatedButton(
                          child: const Text(
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
                                await _authService.signIn(
                                    emailCont: _emailController.text.trim(),
                                    passCont: _passController.text.trim());

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
                    const Text("Don't have an Account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('RegisterScreen');
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: _greenColor),
                      ),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    UserModel result = await _authService.singInAnnon();
                    // ignore: avoid_print
                    print('user Signed in');
                    // ignore: avoid_print
                    print(result.uid);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('HomePage', (route) => false);
                  },
                  child: const Text("Sign in Anonymously"),
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
    required this.obscureText,
    TextEditingController? controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController? _controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: TextFormField(
        validator: validator,
        obscureText: obscureText,
        controller: _controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 1.5)),
            labelText: labelText,
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
