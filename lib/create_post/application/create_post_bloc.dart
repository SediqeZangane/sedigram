// ignore_for_file: omit_local_variable_types

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:sedigram/create_post/application/create_post_event.dart';
import 'package:sedigram/create_post/application/create_post_state.dart';
import 'package:sedigram/create_post/domain/model/folder_path_model.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  List<FolderPathModel>? list;

  CreatePostBloc() : super(CreatePostState.init()) {
    on<CreatePostEvent>((event, emit) async {
      if (event is GetImagesEvent) {
        emit(state.copyWith(gettingImages: true, folderList: []));
        final imagePath = await StoragePath.imagesPath;
        if (imagePath != null) {
          final images = jsonDecode(imagePath) as List;
          final pathFolders = images.map(
            (dynamic e) {
              // FolderPathModel.fromJson(
              //   Map<String, dynamic>.from(e as Map),
              // )
              final map = e as Map;
              final json = Map<String, dynamic>.from(map);
              return FolderPathModel.fromJson(json);
            },
          ).toList();
          emit(
            state.copyWith(
              gettingImages: false,
              folderList: pathFolders,
              folder: pathFolders.first,
              selectedPath: pathFolders.first.files.first,
            ),
          );
        } else {
          emit(state.copyWith(gettingImages: false, folderList: []));
        }
      }
      if (event is ChangeFoldersEvent) {
        emit(
          state.copyWith(
            folder: event.selectedFolder,
            selectedPath: event.selectedFolder.files.first,
          ),
        );
      }
      if (event is SelectedImagesEvent) {
        emit(state.copyWith(selectedPath: event.path));
      }
    });
  }
}
