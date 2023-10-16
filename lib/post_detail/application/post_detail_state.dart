import 'package:sedigram/core/domain/post.dart';

class PostDetailState {
  final List<Post> posts;
  final bool isMine;

  PostDetailState({
    required this.posts,
    required this.isMine,
  });

  PostDetailState.init()
      : posts = [],
        isMine = false;

  PostDetailState copyWith({
    List<Post>? posts,
    bool? isMine,
  }) {
    return PostDetailState(
      posts: posts ?? this.posts,
      isMine: isMine ?? this.isMine,
    );
  }
}
