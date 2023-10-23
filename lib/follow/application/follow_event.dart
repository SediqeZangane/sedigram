import 'package:sedigram/core/domain/user_info.dart';

abstract class FollowEvent {}

class FollowInitEvent implements FollowEvent {
  final UserInfo userInfo;

  const FollowInitEvent({
    required this.userInfo,
  });
}
