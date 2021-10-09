import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todoapp/models/user_model.dart';

class DatabaseService {
  String? uid;
  DatabaseService({this.uid});

  // final CollectionReference userCollection =
  //     FirebaseFirestore.instance.collection("users");
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future updateUserData(String username, String email) async {
    return await _firestore
    .collection("users")
    .doc(uid)
    .set({
      "username": username,
      "email": email,
    });
  }

  //userData from snapshot

  Stream<QuerySnapshot> get userData {
    return _firestore
    .collection("users")
    .snapshots();
  }

  //user list from snapshot
  
}
