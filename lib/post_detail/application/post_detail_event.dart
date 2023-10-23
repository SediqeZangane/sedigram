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

class PostDetailLikeEvent implements PostDetailEvent {
  final Post likedPost;

  PostDetailLikeEvent({
    required this.likedPost,
  });
}

class PostDetailUnLikeEvent implements PostDetailEvent {
  final Post unLikedPost;

  PostDetailUnLikeEvent({
    required this.unLikedPost,
  });
}
