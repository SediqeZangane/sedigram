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
}
