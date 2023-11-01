class EditImageState {
  final String croppedImage;

  const EditImageState({
    required this.croppedImage,
  });

  EditImageState.init() : croppedImage = '';

  EditImageState copyWith({
    String? croppedImage,
  }) {
    return EditImageState(
      croppedImage: croppedImage ?? this.croppedImage,
    );
  }
}
