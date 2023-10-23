import 'package:sedigram/core/domain/user.dart';

class FollowState {
  final List<User> listUserFollowings;
  final List<User> listUserFollowers;

  const FollowState({
    required this.listUserFollowings,
    required this.listUserFollowers,
  });

  FollowState.init()
      : listUserFollowings = [],
        listUserFollowers = [];

  FollowState copyWith({
    List<User>? listUserFollowings,
    List<User>? listUserFollowers,
  }) {
    return FollowState(
      listUserFollowings: listUserFollowings ?? this.listUserFollowings,
      listUserFollowers: listUserFollowers ?? this.listUserFollowers,
    );
  }
}
