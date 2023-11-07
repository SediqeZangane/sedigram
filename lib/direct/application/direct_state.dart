import 'package:sedigram/core/domain/chat.dart';
import 'package:sedigram/core/domain/user.dart';

class DirectState {
  final List<Chat> listChats;
  final List<User>? listUsers;

  const DirectState({
    required this.listChats,
    required this.listUsers,
  });

  DirectState.init()
      : listChats = [],
        listUsers = null;

  DirectState copyWith({
    List<Chat>? listChats,
    List<User>? listUsers,
  }) {
    return DirectState(
      listChats: listChats ?? this.listChats,
      listUsers: listUsers ?? this.listUsers,
    );
  }
}
