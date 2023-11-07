import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/chat_room/presentation/chat_room_screen.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/core/domain/chat.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/new_message/application/new_message_event.dart';
import 'package:sedigram/new_message/application/new_message_state.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:uuid/uuid.dart';

class NewMessageBloc extends Bloc<NewMessageEvent, NewMessageState> {
  final GlobalUserBloc globalUserBloc;
  final FirestoreService firestoreService;

  NewMessageBloc({
    required this.globalUserBloc,
    required this.firestoreService,
  }) : super(NewMessageState.init()) {
    on<NewMessageEvent>((event, emit) async {
      if (event is NewMessageInitEvent) {
        final followings = globalUserBloc.state.userInfo.followings;

        final List<User> listUserFollowings = [];
        for (var i = 0; i < followings.length; i++) {
          final userFollowings = await firestoreService.getUser(followings[i]);
          listUserFollowings.add(userFollowings);
        }

        emit(
          state.copyWith(
            listUserFollowings: listUserFollowings,
            listSearchFollowings: listUserFollowings,
          ),
        );
      }
      if (event is NewMessageSearchEvent) {
        final items = state.listUserFollowings;

        final filteredItems = items.where((item) {
          return item.userName
              .toLowerCase()
              .contains(event.searchText.toLowerCase());
        }).toList();
        emit(state.copyWith(listSearchFollowings: filteredItems));
      }

      if (event is NewMessageSelectUserEvent) {
        final ownerUserId = globalUserBloc.state.user.userId;
        var chat = await firestoreService.getChatByUserIds(
          senderId: ownerUserId,
          receiver: event.selectedUser,
        );
        if (chat == null) {
          final userIds = [ownerUserId, event.selectedUser];
          const uuid = Uuid();
          final id = uuid.v4();

          chat = Chat(id: id, userIds: userIds);
          await firestoreService.createChat(chat);
        }
        await event.navigatorState.pushNamed(
          ChatRoomScreen.routeNamed,
          arguments: chat,
        );
      }
    });
  }
}
