import 'package:sedigram/core/domain/post.dart';
import 'package:sedigram/core/domain/user.dart';

class PostDetailModel {
  final Post post;
  final User user;
  final bool isMine;
  final bool liked;

  PostDetailModel(
    this.post,
    this.user,
    // ignore: avoid_positional_boolean_parameters
    this.isMine,
    this.liked,
  );

  PostDetailModel copyWith({
    Post? post,
    User? user,
    bool? isMine,
    bool? liked,
  }) {
    return PostDetailModel(
      post ?? this.post,
      user ?? this.user,
      isMine ?? this.isMine,
      liked ?? this.liked,
    );
  }
}
