abstract class ChatRoomEvent {}

class ChatRoomInitEvent implements ChatRoomEvent {}

class ChatRoomCreateEvent implements ChatRoomEvent {
  final String message;

  const ChatRoomCreateEvent({
    required this.message,
  });
}
