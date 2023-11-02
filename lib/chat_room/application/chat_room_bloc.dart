import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/chat_room/application/chat_room_event.dart';
import 'package:sedigram/chat_room/application/chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  ChatRoomBloc() : super(ChatRoomState.init()) {
    on<ChatRoomEvent>((event, emit) {
      if (event is ChatRoomInitEvent) {}
    });
  }
}
