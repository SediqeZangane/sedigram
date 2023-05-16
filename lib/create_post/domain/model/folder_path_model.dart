import 'package:json_annotation/json_annotation.dart';

part 'folder_path_model.g.dart';

@JsonSerializable()
class FolderPathModel {
  final List<String> files;
  final String folderName;

  FolderPathModel({
    required this.files,
    required this.folderName,
  });

  factory FolderPathModel.fromJson(Map<String, dynamic> json) =>
      _$FolderPathModelFromJson(json);
}
