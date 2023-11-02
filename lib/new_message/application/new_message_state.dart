import 'package:sedigram/core/domain/user.dart';

class NewMessageState {
  final List<User> listUserFollowings;
  final List<User> listSearchFollowings;

  const NewMessageState({
    required this.listUserFollowings,
    required this.listSearchFollowings,
  });

  NewMessageState.init()
      : listUserFollowings = [],
        listSearchFollowings = [];

  NewMessageState copyWith({
    List<User>? listUserFollowings,
    List<User>? listSearchFollowings,
  }) {
    return NewMessageState(
      listUserFollowings: listUserFollowings ?? this.listUserFollowings,
      listSearchFollowings: listSearchFollowings ?? this.listSearchFollowings,
    );
  }
}
