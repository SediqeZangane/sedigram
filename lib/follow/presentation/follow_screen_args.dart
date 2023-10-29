import 'package:sedigram/core/domain/user_info.dart';

class FollowScreenArgs {
  final UserInfo userInfo;
  final int initIndex;

  const FollowScreenArgs({
    required this.userInfo,
    required this.initIndex,
  });
}
