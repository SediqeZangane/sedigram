import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sedigram/core/domain/post.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/core/domain/user_info.dart';

class FirestoreService {
  final FirebaseFirestore firebaseFirestore;

  FirestoreService(this.firebaseFirestore);

  Future<User> getUser(String userId) async {
    final userDoc = firebaseFirestore.collection('users').doc(userId);
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
    final collection = firebaseFirestore.collection('users');
    final doc = collection.doc(updatedUser.userId);
    final exist = (await doc.get()).exists;
    if (exist) {
      return doc.update(updatedUser.toJson());
    } else {
      return doc.set(updatedUser.toJson());
    }
  }

  Future<UserInfo> getUserInfo(String userId) async {
    final userInfoDoc = firebaseFirestore.collection('userInfo').doc(userId);
    final userInfoDocSnapshot = await userInfoDoc.get();
    final userInfo = userInfoDocSnapshot.data();
    if (userInfo != null) {
      return UserInfo.fromJson(userInfo);
    } else {
      return UserInfo.empty().copyWith(userId: userId);
    }
  }

  Future<void> updateUserInfo(UserInfo updatedUserInfo) async {
    final collection = firebaseFirestore.collection('userInfo');
    final doc = collection.doc(updatedUserInfo.userId);
    final exist = (await doc.get()).exists;
    if (exist) {
      return doc.update(updatedUserInfo.toJson());
    } else {
      return doc.set(updatedUserInfo.toJson());
    }
  }

  Future<bool> insertPosts(Post newPost) async {
    final collection = firebaseFirestore.collection('posts');
    final doc = collection.doc(newPost.postId);

    try {
      await doc.set(newPost.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<List<Post>> getPosts(String userId) async {
    final postsQuery = firebaseFirestore
        .collection('posts')
        .where('userId', isEqualTo: userId);

    final querySnapshot = await postsQuery.get();

    final listPosts = querySnapshot.docs.map((doc) {
      return Post.fromJson(doc.data());
    }).toList();
    return listPosts;
  }
}
