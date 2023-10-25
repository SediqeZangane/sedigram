class ProfilePhotoState {
  final bool isLoading;

  ProfilePhotoState({
    required this.isLoading,
  });

  ProfilePhotoState.init() : isLoading = false;

  ProfilePhotoState copyWith({
    bool? isLoading,
  }) {
    return ProfilePhotoState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
