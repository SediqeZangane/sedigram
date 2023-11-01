abstract class SavePostEvent {}

class SavePostInitEvent implements SavePostEvent {
  final String imagePath;

  const SavePostInitEvent({
    required this.imagePath,
  });
}

class SavePostUploadEvent implements SavePostEvent {
  final String caption;

  SavePostUploadEvent({required this.caption});
}

class SavePostEditEvent implements SavePostEvent {}
