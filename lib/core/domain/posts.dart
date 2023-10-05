import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  String id;
  String caption;
  String imageUrl;
  Timestamp createdAt;
  String userId;

  Posts({
    required this.id,
    required this.caption,
    required this.imageUrl,
    required this.createdAt,
    required this.userId,
  });
}
