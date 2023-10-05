import 'package:json_annotation/json_annotation.dart';

part 'posts.g.dart';

@JsonSerializable()
class Posts {
  String postId;
  String caption;
  String imageUrl;
  int createdAt;
  String userId;

  Posts({
    required this.postId,
    required this.caption,
    required this.imageUrl,
    required this.createdAt,
    required this.userId,
  });

  Posts.empty()
      : postId = '',
        caption = '',
        imageUrl = '',
        createdAt = DateTime.now().millisecondsSinceEpoch,
        userId = '';

  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);

  Map<String, dynamic> toJson() => _$PostsToJson(this);

  Posts copyWith({
    String? postId,
    String? caption,
    String? imageUrl,
    int? createdAt,
    String? userId,
  }) {
    return Posts(
      postId: postId ?? this.postId,
      caption: caption ?? this.caption,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }
}
