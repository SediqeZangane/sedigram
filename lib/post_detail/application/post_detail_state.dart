import 'package:sedigram/core/domain/post.dart';

class PostDetailState {
  final List<Post> posts;

  PostDetailState({required this.posts});

  PostDetailState.init() : posts = [];

  PostDetailState copyWith({
    List<Post>? posts,
  }) {
    return PostDetailState(
      posts: posts ?? this.posts,
    );
  }
}
