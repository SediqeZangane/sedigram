import 'package:sedigram/core/domain/post.dart';

class PostDetailScreenArguments {
  final List<Post> posts;
  final int postIndex;
  final String userName;

  const PostDetailScreenArguments({
    required this.posts,
    required this.postIndex,
    required this.userName,
  });
}
