import 'package:sedigram/core/domain/user.dart';

class FollowState {
  final List<User> listUserFollowings;
  final List<User> listUserFollowers;
  final List<User> listSearchFollowings;
  final List<User> listSearchFollowers;

  const FollowState({
    required this.listUserFollowings,
    required this.listUserFollowers,
    required this.listSearchFollowings,
    required this.listSearchFollowers,
  });

  FollowState.init()
      : listUserFollowings = [],
        listUserFollowers = [],
        listSearchFollowings = [],
        listSearchFollowers = [];

  FollowState copyWith({
    List<User>? listUserFollowings,
    List<User>? listUserFollowers,
    List<User>? listSearchFollowings,
    List<User>? listSearchFollowers,
  }) {
    return FollowState(
      listUserFollowings: listUserFollowings ?? this.listUserFollowings,
      listUserFollowers: listUserFollowers ?? this.listUserFollowers,
      listSearchFollowings: listSearchFollowings ?? this.listSearchFollowings,
      listSearchFollowers: listSearchFollowers ?? this.listSearchFollowers,
    );
  }
}
