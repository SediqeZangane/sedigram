import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/create_post/application/create_post_bloc.dart';
import 'package:sedigram/create_post/application/create_post_event.dart';
import 'package:sedigram/create_post/application/create_post_state.dart';
import 'package:sedigram/create_post/domain/model/folder_path_model.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CreatePostBloc, CreatePostState>(
          builder: (context, state) {
            if (state.gettingImages) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.folderList.isEmpty || state.folderList[0].files.isEmpty) {
              return const SizedBox.shrink();
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Icon(Icons.clear),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: state.folder,
                              items: getFolders(state.folderList),
                              onChanged: (folderPathModel) {
                                if (folderPathModel != null) {
                                  context.read<CreatePostBloc>().add(
                                        ChangeFoldersEvent(
                                          selectedFolder: folderPathModel,
                                        ),
                                      );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child:
                            Text('Next', style: context.textTheme.titleMedium),
                      )
                    ],
                  ),
                  const Divider(),
                  Container(
                    color: context.colorScheme.onSurface,
                    height: (context.screenHeight) * 0.45,
                    child: state.selectedPath != null
                        ? Image.file(File(state.selectedPath!))
                        : const SizedBox.shrink(),
                  ),
                  const Divider(),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final folder = state.folder;
                        if (folder != null) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                            ),
                            itemBuilder: (context, index) {
                              final path = folder.files[index];
                              return GestureDetector(
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      File(path),
                                      fit: BoxFit.cover,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Visibility(
                                        visible: state.selectedPath == path,
                                        child: const Icon(Icons.check_circle),
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  context
                                      .read<CreatePostBloc>()
                                      .add(SelectedImagesEvent(path: path));
                                },
                              );
                            },
                            itemCount: folder.files.length,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<FolderPathModel>> getFolders(
    List<FolderPathModel> state,
  ) {
    return state
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e.folderName),
          ),
        )
        .toList();
  }
}
