class SavePostState {
  final bool isLoading;
  final bool uploaded;

  SavePostState({
    required this.isLoading,
    required this.uploaded,
  });

  SavePostState.init()
      : isLoading = false,
        uploaded = false;

  SavePostState copyWith({
    String? caption,
    bool? isLoading,
    bool? uploaded,
  }) {
    return SavePostState(
      isLoading: isLoading ?? this.isLoading,
      uploaded: uploaded ?? this.uploaded,
    );
  }
}
