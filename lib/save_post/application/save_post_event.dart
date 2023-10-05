abstract class SavePostEvent {}

class SavePostUploadEvent implements SavePostEvent {
  final String imagePath;

  SavePostUploadEvent({required this.imagePath});
}
