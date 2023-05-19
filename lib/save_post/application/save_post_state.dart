class SavePostState {
  final String? imageSelected;

  SavePostState({required this.imageSelected});

  SavePostState.init() : imageSelected = null;

  SavePostState copyWith({String? imageSelected}) {
    return SavePostState(
      imageSelected: imageSelected ?? this.imageSelected,
    );
  }
}
