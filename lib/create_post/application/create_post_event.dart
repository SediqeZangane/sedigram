import 'package:sedigram/create_post/domain/model/folder_path_model.dart';

abstract class CreatePostEvent {}

class GetImagesEvent implements CreatePostEvent {}

class ChangeFoldersEvent implements CreatePostEvent {
  final FolderPathModel selectedFolder;

  ChangeFoldersEvent({required this.selectedFolder});
}

class SelectedImagesEvent implements CreatePostEvent {
  final String path;

  SelectedImagesEvent({required this.path});
}
