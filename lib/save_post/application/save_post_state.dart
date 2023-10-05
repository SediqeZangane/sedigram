class SavePostState {
  final String? caption;
  final bool isLoading;
  final bool uploaded;

  SavePostState({
    required this.caption,
    required this.isLoading,
    required this.uploaded,
  });

  SavePostState.init()
      : caption = '',
        isLoading = false,
        uploaded = false;

  SavePostState copyWith({
    String? caption,
    bool? isLoading,
    bool? uploaded,
  }) {
    return SavePostState(
      caption: caption ?? this.caption,
      isLoading: isLoading ?? this.isLoading,
      uploaded: uploaded ?? this.uploaded,
    );
  }
}
