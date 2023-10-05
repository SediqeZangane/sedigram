import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/core/domain/user_info.dart';

class FirestoreService {
  Future<User> getUser(String userId) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final userSnapshot = await userDoc.get();
    // Map<String, dynamic>?
    final userData = userSnapshot.data();
    if (userData != null) {
      return User.fromJson(userData);
    } else {
      return User.empty().copyWith(userId: userId);
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

  Future<UserInfo> getUserInfo(String userId) async {
    final userInfoDoc =
        FirebaseFirestore.instance.collection('userInfo').doc(userId);
    final userInfoDocSnapshot = await userInfoDoc.get();
    final userInfo = userInfoDocSnapshot.data();
    if (userInfo != null) {
      return UserInfo.fromJson(userInfo);
    } else {
      return UserInfo.empty().copyWith(userId: userId);
    }
  }
}
