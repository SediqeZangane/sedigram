import 'package:sedigram/core/domain/post.dart';

class PostDetailScreenArguments {
  final List<Post> posts;
  final int postIndex;

  const PostDetailScreenArguments({
    required this.posts,
    required this.postIndex,
  });
}
