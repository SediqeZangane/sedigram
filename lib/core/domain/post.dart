import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final String postId;
  final String caption;
  final String imageUrl;
  final int createdAt;
  final String userId;
  @JsonKey(defaultValue: [])
  final List<String> likes;

  Post({
    required this.postId,
    required this.caption,
    required this.imageUrl,
    required this.createdAt,
    required this.userId,
    required this.likes,
  });

  Post.empty()
      : postId = '',
        caption = '',
        imageUrl = '',
        createdAt = DateTime.now().millisecondsSinceEpoch,
        userId = '',
        likes = [];

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    String? postId,
    String? caption,
    String? imageUrl,
    int? createdAt,
    String? userId,
    List<String>? likes,
  }) {
    return Post(
      postId: postId ?? this.postId,
      caption: caption ?? this.caption,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      likes: likes ?? this.likes,
    );
  }
}
