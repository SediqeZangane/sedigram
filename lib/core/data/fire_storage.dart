import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FireStorage {
  final FirebaseStorage firebaseStorage;

  FireStorage(this.firebaseStorage);

  Future<String?> uploadImageFile(
    String imageFilePath,
    String imageFileName,
    String userId,
  ) async {
    final file = File(imageFilePath);

    try {
      final uploadTaskSnapshot =
          await firebaseStorage.ref('$userId/$imageFileName').putFile(file);
      return await uploadTaskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint('error is = $e');
      return null;
    }
  }
}
