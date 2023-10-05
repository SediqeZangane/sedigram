abstract class SavePostEvent {}

class SavePostUploadEvent implements SavePostEvent {
  final String imagePath;
  final String caption;

  SavePostUploadEvent({required this.imagePath, required this.caption});
}
