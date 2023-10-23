import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  String postId;
  String caption;
  String imageUrl;
  int createdAt;
  String userId;
  @JsonKey(defaultValue: [])
  List<String> likes;

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
