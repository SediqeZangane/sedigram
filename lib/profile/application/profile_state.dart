import 'package:sedigram/core/domain/post.dart';

class ProfileState {
  final bool isLoading;
  final String error;
  final List<Post> posts;

  ProfileState({
    required this.isLoading,
    required this.error,
    required this.posts,
  });

  ProfileState.init()
      : isLoading = false,
        error = '',
        posts = [];

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    List<Post>? posts,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      posts: posts ?? this.posts,
    );
  }
}
