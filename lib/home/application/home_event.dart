abstract class HomeEvent {}

class ChangedBottomNavigation implements HomeEvent {
  final int index;

  ChangedBottomNavigation({required this.index});
}
