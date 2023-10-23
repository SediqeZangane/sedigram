import 'package:sedigram/core/presentation/model/post_details_model.dart';

class PostDetailState {
  final List<PostDetailModel> posts;

  PostDetailState({
    required this.posts,
  });

  PostDetailState.init() : posts = [];

  PostDetailState copyWith({
    List<PostDetailModel>? posts,
  }) {
    return PostDetailState(
      posts: posts ?? this.posts,
    );
  }
}
