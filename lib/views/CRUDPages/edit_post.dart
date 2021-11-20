import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_todoapp/models/post_model.dart';
import 'package:firebase_todoapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'dart:io';

class EditPost extends StatefulWidget {
  final Posts post;

  const EditPost({Key? key, required this.post}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

final titleController = TextEditingController();
final descriptionController = TextEditingController();

class _EditPostState extends State<EditPost> {
  final db = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  String? imagePath;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.post.title;
    descriptionController.text = widget.post.description;
  }

  @override
  void dispose() {
    titleController.clear();
    descriptionController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseStorage storage = FirebaseStorage.instance;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0.1,
        title: const Text(
          'Edit post',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              try {
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  imagePath = image?.path;
                });
              } on FirebaseException catch (e) {
                // ignore: avoid_print
                print(e);
              }
            },
            icon: const Icon(
              Icons.image_outlined,
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: () async {
              if (imagePath != null) {
                await storage.refFromURL(widget.post.photo).delete();
                String imageName = path.basename(imagePath!);
                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/$imageName');

                File file = File(imagePath!);
                await ref.putFile(file);
                String downloadURL = await ref.getDownloadURL();
                await DatabaseService(docid: widget.post.id).updatePosts(
                    titleController.text.trim(),
                    descriptionController.text.trim(),
                    downloadURL);
                // ignore: avoid_print
                print('File uploaded successfuly');
                titleController.clear();
                descriptionController.clear();
              } else {
                // ignore: avoid_print
                print('Please select an image first');
              }

              imagePath = null;
            },
            child: const Text(
              'Edit',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff00D959),
              ),
            ),
          ),
        ],
      ),
      body: const PostBody(),
    );
  }
}

class PostBody extends StatefulWidget {
  const PostBody({Key? key}) : super(key: key);

  @override
  _PostBodyState createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: const InputDecoration.collapsed(
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 20),
              ),
              controller: titleController,
              autofocus: true,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              endIndent: 25,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: descriptionController,
                decoration: const InputDecoration.collapsed(
                    hintText: 'Write your article'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
