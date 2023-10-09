import 'package:sedigram/core/domain/post.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/core/domain/user_info.dart';

class ProfileState {
  final bool isLoading;
  final User currentUser;
  final String error;
  final UserInfo userInfo;
  final List<Post> posts;

  ProfileState({
    required this.isLoading,
    required this.currentUser,
    required this.error,
    required this.userInfo,
    required this.posts,
  });

  ProfileState.init()
      : isLoading = false,
        currentUser = User.empty(),
        error = '',
        userInfo = UserInfo.empty(),
        posts = [];

  ProfileState copyWith({
    bool? isLoading,
    User? currentUser,
    String? error,
    UserInfo? userInfo,
    List<Post>? posts,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      error: error ?? this.error,
      userInfo: userInfo ?? this.userInfo,
      posts: posts ?? this.posts,
    );
  }
}
