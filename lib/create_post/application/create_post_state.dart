import 'package:sedigram/create_post/domain/model/folder_path_model.dart';

class CreatePostState {
  final bool gettingImages;
  final List<FolderPathModel> folderList;
  final FolderPathModel? folder;
  final String? selectedPath;

  CreatePostState({
    required this.gettingImages,
    required this.folderList,
    required this.folder,
    required this.selectedPath,
  });

  CreatePostState.init()
      : gettingImages = false,
        folderList = [],
        folder = null,
        selectedPath = null;

  CreatePostState copyWith({
    bool? gettingImages,
    List<FolderPathModel>? folderList,
    FolderPathModel? folder,
    String? selectedPath,
  }) {
    return CreatePostState(
      gettingImages: gettingImages ?? this.gettingImages,
      folderList: folderList ?? this.folderList,
      folder: folder ?? this.folder,
      selectedPath: selectedPath ?? this.selectedPath,
    );
  }
}
