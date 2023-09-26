import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/create_post/application/create_post_bloc.dart';
import 'package:sedigram/create_post/application/create_post_event.dart';
import 'package:sedigram/create_post/application/create_post_state.dart';
import 'package:sedigram/create_post/domain/model/folder_path_model.dart';
import 'package:sedigram/save_post/presentation/save_post_screen.dart';

class CreatePostScreen extends StatelessWidget {
  static const String routeNamed = 'createPostScreen';

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
                        child: InkWell(
                          child: Text(
                            context.localization.nextButton,
                            style: context.textTheme.titleMedium
                                ?.copyWith(color: context.colorScheme.primary),
                          ),
                          onTap: () {
                            if (state.selectedPath != null) {
                              Navigator.of(context).pushNamed<void>(
                                SavePostScreen.routeNamed,
                                arguments: state.selectedPath,
                              );

                              // Navigator.of(context).push<void>(
                              //   MaterialPageRoute(
                              //     builder: (context) => BlocProvider(
                              //       child: SavePostScreen(
                              //         imagePath: state.selectedPath!,
                              //       ),
                              //       create: (context) => SavePostBloc(),
                              //     ),
                              //   ),
                              // );
                            }
                          },
                        ),
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
