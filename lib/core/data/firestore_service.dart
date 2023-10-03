import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sedigram/core/domain/user.dart';

class FirestoreService {
  Future<User> getUser(String userId) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final userSnapshot = await userDoc.get();
    // Map<String, dynamic>?
    final userData = userSnapshot.data();
    if (userData != null) {
      return User.fromJson(userData);
    } else {
      return User(
        userId: userId,
        name: '',
        userName: '',
        webSite: '',
        bio: '',
        email: '',
        phone: '',
        gender: '',
      );
    }
  }

  Future<void> updateUser(User updatedUser) async {
    final collection = FirebaseFirestore.instance.collection('users');
    final doc = collection.doc(updatedUser.userId);
    final exist = (await doc.get()).exists;
    if (exist) {
      return doc.update(updatedUser.toJson());
    } else {
      return doc.set(updatedUser.toJson());
    }
  }
}
