import 'package:sedigram/core/domain/post.dart';
import 'package:sedigram/core/domain/user.dart';

class PostDetailModel {
  final Post post;
  final User user;
  final bool isMine;

  PostDetailModel(
    this.post,
    this.user,
    // ignore: avoid_positional_boolean_parameters
    this.isMine,
  );
}
