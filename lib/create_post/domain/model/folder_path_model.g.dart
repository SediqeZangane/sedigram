// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_path_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderPathModel _$FolderPathModelFromJson(Map<String, dynamic> json) =>
    FolderPathModel(
      files: (json['files'] as List<dynamic>).map((e) => e as String).toList(),
      folderName: json['folderName'] as String,
    );

Map<String, dynamic> _$FolderPathModelToJson(FolderPathModel instance) =>
    <String, dynamic>{
      'files': instance.files,
      'folderName': instance.folderName,
    };
