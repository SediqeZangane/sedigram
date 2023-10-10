import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/core/domain/user_info.dart';

class GlobalUserState {
  final User user;
  final UserInfo userInfo;

  GlobalUserState({
    required this.user,
    required this.userInfo,
  });

  GlobalUserState.init()
      : user = User.empty(),
        userInfo = UserInfo.empty();

  GlobalUserState copyWith({
    User? user,
    UserInfo? userInfo,
  }) {
    return GlobalUserState(
      user: user ?? this.user,
      userInfo: userInfo ?? this.userInfo,
    );
  }
}
