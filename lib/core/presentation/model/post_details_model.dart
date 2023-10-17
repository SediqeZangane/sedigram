import 'package:sedigram/core/domain/post.dart';
import 'package:sedigram/core/domain/user.dart';

class PostDetailModel {
  final Post post;
  final User user;

  PostDetailModel(this.post, this.user);
}
