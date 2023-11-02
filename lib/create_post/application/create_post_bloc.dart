// ignore_for_file: omit_local_variable_types

import 'dart:io';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sedigram/create_post/application/create_post_event.dart';
import 'package:sedigram/create_post/application/create_post_state.dart';
import 'package:sedigram/create_post/domain/model/folder_path_model.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(CreatePostState.init()) {
    on<CreatePostEvent>((event, emit) async {
      if (event is GetImagesEvent) {
        emit(state.copyWith(gettingImages: true, folderList: []));

        await PhotoManager.requestPermissionExtend();
        final folders = await PhotoManager.getAssetPathList(
          type: RequestType.image,
        );

        final pathFolders = await Future.wait(
          folders.sublist(0, min(folders.length, 4)).map(
            (e) async {
              final entities = await e.getAssetListPaged(page: 0, size: 200);
              final files =
                  await Future.wait(entities.map((en) async => en.file));
              return FolderPathModel(
                files: files
                    .whereType<File>()
                    .map((f) => f.absolute.path)
                    .toList(),
                folderName: e.name,
              );
            },
          ),
        );

        emit(
          state.copyWith(
            gettingImages: false,
            folderList: pathFolders,
            folder: pathFolders.first,
            selectedPath: pathFolders.first.files.first,
          ),
        );
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
