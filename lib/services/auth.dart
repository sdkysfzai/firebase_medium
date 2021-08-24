import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todoapp/models/userModel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // user model
  UserModel? _userFromFirebase(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //auth state change stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //sign in Annonymously

  Future singInAnnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign in with Email and Password

//register with email and password

//signOut
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Failed to signout");
      print(e.toString());
    }
  }
}
