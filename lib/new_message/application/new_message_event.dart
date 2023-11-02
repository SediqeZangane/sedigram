abstract class NewMessageEvent {}

class NewMessageInitEvent implements NewMessageEvent {}

class NewMessageSearchEvent implements NewMessageEvent {
  final String searchText;

  const NewMessageSearchEvent({
    required this.searchText,
  });
}
