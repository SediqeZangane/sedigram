import 'package:sedigram/core/domain/post.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/core/domain/user_info.dart';

class ProfileState {
  final bool isLoading;
  final String error;
  final List<Post> posts;
  final User user;
  final UserInfo userInfo;

  ProfileState({
    required this.isLoading,
    required this.error,
    required this.posts,
    required this.user,
    required this.userInfo,
  });

  ProfileState.init()
      : isLoading = false,
        error = '',
        posts = [],
        user = User.empty(),
        userInfo = UserInfo.empty();

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    List<Post>? posts,
    User? user,
    UserInfo? userInfo,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      posts: posts ?? this.posts,
      user: user ?? this.user,
      userInfo: userInfo ?? this.userInfo,
    );
  }
}
