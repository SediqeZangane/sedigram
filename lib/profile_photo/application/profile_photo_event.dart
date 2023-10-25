abstract class ProfilePhotoEvent {}

class ProfilePhotoSaveEvent implements ProfilePhotoEvent {
  final String imagePath;

  const ProfilePhotoSaveEvent({
    required this.imagePath,
  });
}
