import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todoapp/services/auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _usernameController = TextEditingController();
  String _message = "";
  final Color _greenColor = const Color(0xff00D959);
  final _formKey = GlobalKey<FormState>();
  bool _isLogginIn = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _usernameController.dispose();
    // ignore: avoid_print
    print("Register disposer called");
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
                      padding: const EdgeInsets.fromLTRB(20, 130, 150, 0),
                      child: const Text(
                        "Register \n Account",
                        style: TextStyle(
                            fontSize: 55, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(240, 171, 0, 0),
                      child: Text(
                        ".",
                        style: TextStyle(
                            color: _greenColor,
                            fontSize: 80,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 64,
                ),
                RegisterFormField(
                  labelText: "Username",
                  controller: _usernameController,
                ),
                RegisterFormField(
                  labelText: "Email",
                  controller: _emailController,
                  validator: validateEmail,
                ),
                RegisterFormField(
                  labelText: "Password",
                  controller: _passController,
                  validator: validatePass,
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
                  height: 50,
                  width: 280,
                  child: _isLogginIn
                      ? CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _greenColor,
                        )
                      : ElevatedButton(
                          child: const Text(
                            "Register",
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
                              _isLogginIn = true;
                              _message = "";
                            });
                            if (_formKey.currentState!.validate()) {
                              try {
                                final UserCredential user =
                                    await _authService.signUp(
                                        emailCont: _emailController.text.trim(),
                                        passCont: _passController.text.trim());

                                await _firestore
                                    .collection("users")
                                    .doc(user.user?.uid)
                                    .set({
                                  "username": _usernameController.text.trim(),
                                  "email": _emailController.text.trim()
                                });
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'HomePage', (route) => false);
                              } on FirebaseAuthException catch (e) {
                                switch (e.code) {
                                  case 'email-already-in-use':
                                    _message = 'Error: Email already in use!';
                                    break;
                                  case 'invalid-email':
                                    _message = 'Error: Invalid email adress!';
                                    break;
                                  case 'operation-not-allowed':
                                    _message = 'Error: Something went wrong!';
                                    break;
                                  case 'weak-password':
                                    _message = 'Error: Weak password!';
                                    break;
                                  default:
                                    _message = "Something went wrong!";
                                }
                              }
                            }
                            setState(() {
                              _isLogginIn = false;
                            });
                          },
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an Account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('LoginScreen');
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: _greenColor),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class RegisterFormField extends StatelessWidget {
   const RegisterFormField({
    this.validator,
    Key? key,
    required this.labelText,
    TextEditingController? controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController? _controller;
  final String labelText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: TextFormField(
        validator: validator,
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

String? validatePass(String? formPass) {
  if (formPass == null || formPass.isEmpty) {
    return 'Password cannot be empty!';
  }
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[_!@#\$&*~]).{8,}$';
  RegExp regEx = RegExp(pattern);
  if (!regEx.hasMatch(formPass)) {
    return '''
    Password must be atleast 8 characters,
    include an uppercase letter, number and symbol.
        ''';
  }

  return null;
}
