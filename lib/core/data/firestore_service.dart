import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        .orderBy('createdAt', descending: true)
        .where('userId', isEqualTo: userId);

    final querySnapshot = await postsQuery.get();

    final listPosts = querySnapshot.docs.map((doc) {
      return Post.fromJson(doc.data());
    }).toList();
    return listPosts;
  }

  Future<void> deletePost(String userId, String postId) async {
    final userInfo = await getUserInfo(userId);
    userInfo.posts.removeWhere((element) => element == postId);
    await updateUserInfo(userInfo);
    final postDoc = firebaseFirestore.collection('posts').doc(postId);
    await postDoc.delete();
  }

  Future<List<User>> getAllUsers(String query) async {
    try {
      final QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('users')
          .where(
            'userName',
            isGreaterThanOrEqualTo: query,
            isLessThan: query.substring(0, query.length - 1) +
                String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),
          )
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final List<QueryDocumentSnapshot<Object?>> listDoc = querySnapshot.docs;
        final List<Map<String, dynamic>> listMap = listDoc
            .where((element) => element.data() != null)
            // ignore: cast_nullable_to_non_nullable
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        // ignore: unnecessary_lambdas
        final listUser = listMap.map((e) => User.fromJson(e)).toList();
        return listUser;
      } else {
        // No users found
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching users: $e');
      return [];
    }
  }

  Future<void> updatePost(Post updatedPost) async {
    final collection = FirebaseFirestore.instance.collection('posts');
    final doc = collection.doc(updatedPost.postId);

    final exist = (await doc.get()).exists;

    if (exist) {
      await doc
          .update(updatedPost.toJson())
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    } else {
      return doc.set(updatedPost.toJson());
    }
  }
}
