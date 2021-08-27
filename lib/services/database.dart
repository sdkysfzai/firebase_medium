import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future updateUserData(String username, String email) async {
    return await userCollection.doc(uid).set({
      "username": username,
      "email": email,
    });
  }

  //userData from snapshot

  Stream<QuerySnapshot> get userData {
    return userCollection.snapshots();
  }

  //post list from snapshot
}
