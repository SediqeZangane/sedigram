import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/new_message/application/new_message_event.dart';
import 'package:sedigram/new_message/application/new_message_state.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';

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
    });
  }
}
