abstract class EditImageEvent {}

class EditImageInitEvent implements EditImageEvent {
  final String imagePath;

  const EditImageInitEvent({
    required this.imagePath,
  });
}
