import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_todoapp/models/post_model.dart';
import 'package:flutter/material.dart';
class DeletePost extends StatelessWidget {
  const DeletePost({
    Key? key,
    required this.db,
    required this.post,
    required this.storage,
  }) : super(key: key);

  final FirebaseFirestore db;
  final Posts post;
  final FirebaseStorage storage;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await db
              .collection("posts")
              .doc(post.id)
              .delete();
          await storage.refFromURL(post.photo).delete();
        } catch (e) {
          // ignore: avoid_print
          print('Error: $e');
        }
      },
      child: const Text('Delete Post'),
    );
  }
}
