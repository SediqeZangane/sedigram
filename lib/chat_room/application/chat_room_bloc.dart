import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/chat_room/application/chat_room_event.dart';
import 'package:sedigram/chat_room/application/chat_room_state.dart';
import 'package:sedigram/core/data/firestore_service.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final FirestoreService firestoreService;

  ChatRoomBloc({required this.firestoreService}) : super(ChatRoomState.init()) {
    on<ChatRoomEvent>((event, emit) {
      if (event is ChatRoomInitEvent) {}

      if (event is ChatRoomCreateEvent) {
        // Message newMessage=Messag
        // firestoreService.createMessage(newMessage)
      }
    });
  }
}
