import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/core/domain/user_info.dart';

class ProfileState {
  final bool isLoading;
  final User currentUser;
  final String error;
  final UserInfo userInfo;

  ProfileState({
    required this.isLoading,
    required this.currentUser,
    required this.error,
    required this.userInfo,
  });

  ProfileState.init()
      : isLoading = false,
        currentUser = User.empty(),
        error = '',
        userInfo = UserInfo.empty();

  ProfileState copyWith({
    bool? isLoading,
    User? currentUser,
    String? error,
    UserInfo? userInfo,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      error: error ?? this.error,
      userInfo: userInfo ?? this.userInfo,
    );
  }
}
