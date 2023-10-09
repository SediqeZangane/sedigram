import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  String postId;
  String caption;
  String imageUrl;
  int createdAt;
  String userId;

  Post({
    required this.postId,
    required this.caption,
    required this.imageUrl,
    required this.createdAt,
    required this.userId,
  });

  Post.empty()
      : postId = '',
        caption = '',
        imageUrl = '',
        createdAt = DateTime.now().millisecondsSinceEpoch,
        userId = '';

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    String? postId,
    String? caption,
    String? imageUrl,
    int? createdAt,
    String? userId,
  }) {
    return Post(
      postId: postId ?? this.postId,
      caption: caption ?? this.caption,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }
}
