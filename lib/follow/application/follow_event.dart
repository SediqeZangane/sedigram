import 'package:sedigram/core/domain/user_info.dart';

abstract class FollowEvent {}

class FollowInitEvent implements FollowEvent {
  final UserInfo userInfo;

  const FollowInitEvent({
    required this.userInfo,
  });
}

class FollowersUpdateSearchEvent implements FollowEvent {
  final String followersSearch;

  const FollowersUpdateSearchEvent({
    required this.followersSearch,
  });
}

class FollowingsUpdateSearchEvent implements FollowEvent {
  final String followingsSearch;

  const FollowingsUpdateSearchEvent({
    required this.followingsSearch,
  });
}
