import 'package:sedigram/core/presentation/model/post_details_model.dart';

class PostDetailState {
  final List<PostDetailModel> posts;
  final bool isMine;

  PostDetailState({
    required this.posts,
    required this.isMine,
  });

  PostDetailState.init()
      : posts = [],
        isMine = false;

  PostDetailState copyWith({
    List<PostDetailModel>? posts,
    bool? isMine,
  }) {
    return PostDetailState(
      posts: posts ?? this.posts,
      isMine: isMine ?? this.isMine,
    );
  }
}
