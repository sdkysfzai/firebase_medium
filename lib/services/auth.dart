import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todoapp/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // user model
  UserModel? _userFromFirebase(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  User? get user {
    return _auth.currentUser;
  }

  //sign in Annonymously

  Future singInAnnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

//sign in with Email and Password
  Future<UserModel?> signIn(
      {required String emailCont, required String passCont}) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: emailCont, password: passCont);
    User? user = result.user;
    return _userFromFirebase(user);
  }

//register with email and password
  Future<UserModel?> signUp({
    required String emailCont,
    required String passCont,
  }) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: emailCont, password: passCont);
    User? user = result.user;

    return _userFromFirebase(user);
  }

//signOut
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print("Failed to signout");
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
