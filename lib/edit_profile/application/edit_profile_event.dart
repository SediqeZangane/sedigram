import 'package:sedigram/core/domain/user.dart';

abstract class EditProfileEvent {}

class EditProfileInitEvent implements EditProfileEvent {}

class EditProfileSaveEvent implements EditProfileEvent {
  final User updateUser;

  EditProfileSaveEvent({required this.updateUser});
}
