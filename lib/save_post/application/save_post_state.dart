class SavePostState {
  final bool isLoading;
  final bool uploaded;
  final String croppedImage;

  const SavePostState({
    required this.isLoading,
    required this.uploaded,
    required this.croppedImage,
  });

  SavePostState.init()
      : isLoading = false,
        uploaded = false,
        croppedImage = '';

  SavePostState copyWith({
    bool? isLoading,
    bool? uploaded,
    String? croppedImage,
  }) {
    return SavePostState(
      isLoading: isLoading ?? this.isLoading,
      uploaded: uploaded ?? this.uploaded,
      croppedImage: croppedImage ?? this.croppedImage,
    );
  }
}
