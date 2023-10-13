abstract class SearchEvent {}

class SearchUpdateEvent implements SearchEvent {
  final String text;

  const SearchUpdateEvent({
    required this.text,
  });
}
