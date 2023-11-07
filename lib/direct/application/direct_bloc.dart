import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/direct/application/direct_event.dart';
import 'package:sedigram/direct/application/direct_state.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';

class DirectBloc extends Bloc<DirectEvent, DirectState> {
  final FirestoreService firestoreService;
  final GlobalUserBloc globalUserBloc;

  DirectBloc({required this.firestoreService, required this.globalUserBloc})
      : super(DirectState.init()) {
    on<DirectEvent>((event, emit) async {
      if (event is DirectInitEvent) {
        final userId = globalUserBloc.state.user.userId;
        final listChats = await firestoreService.getChats(userId);
        final List<String> listReceiverUserIds = [];

        for (var i = 0; i < listChats.length; i++) {
          final receiverUserId =
              listChats[i].userIds.where((element) => element != userId).first;
          listReceiverUserIds.add(receiverUserId);
        }
        final List<User> listUsers = [];

        for (var i = 0; i < listReceiverUserIds.length; i++) {
          final user = await firestoreService.getUser(listReceiverUserIds[i]);
          listUsers.add(user);
        }

        emit(state.copyWith(listUsers: listUsers, listChats: listChats));
      }
    });
  }
}
