class HomeState {
  final int currentIndex;

  HomeState({required this.currentIndex});

  HomeState.init() : currentIndex = 0;

  HomeState copyWith({int? currentIndex}) {
    return HomeState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
