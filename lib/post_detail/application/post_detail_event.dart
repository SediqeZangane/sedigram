import 'package:sedigram/core/domain/post.dart';

abstract class PostDetailEvent {}

class PostDetailDeleteEvent implements PostDetailEvent {
  final Post selectedPost;

  PostDetailDeleteEvent({
    required this.selectedPost,
  });
}

class PostDetailInitEvent implements PostDetailEvent {
  final List<Post> posts;

  const PostDetailInitEvent({
    required this.posts,
  });
}
