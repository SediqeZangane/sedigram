import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sedigram/core/domain/posts.dart';

class FireStorage {
  Future<String?> uploadImageFile(
    String imageFilePath,
    String imageFileName,
    String userId,
  ) async {
    final file = File(imageFilePath);
    final storage = FirebaseStorage.instance;

    try {
      final uploadTaskSnapshot =
          await storage.ref('$userId/$imageFileName').putFile(file);
      return await uploadTaskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print('error is = $e');
      return null;
    }
  }

  Future<bool> insertPosts(Posts newPost) async {
    final collection = FirebaseFirestore.instance.collection('posts');
    final doc = collection.doc(newPost.postId);

    try {
      final isSet = await doc.set(newPost.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }
}
