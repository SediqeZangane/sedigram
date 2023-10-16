import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/save_post/application/save_post_bloc.dart';
import 'package:sedigram/save_post/application/save_post_event.dart';
import 'package:sedigram/save_post/application/save_post_state.dart';

class SavePostScreen extends StatefulWidget {
  static const String routeNamed = 'savePostScreen';

  final String imagePath;

  const SavePostScreen({
    required this.imagePath,
    super.key,
  });

  @override
  State<SavePostScreen> createState() => _SavePostScreenState();
}

class _SavePostScreenState extends State<SavePostScreen> {
  late final TextEditingController captionController;

  @override
  void initState() {
    super.initState();
    captionController = TextEditingController();
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SavePostBloc, SavePostState>(
      listener: (context, state) {
        if (state.uploaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post Uploaded Successfully'),
            ),
          );
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
              ),
              TextField(
                controller: captionController,
                decoration: const InputDecoration(
                  hintText: 'Write your caption . . . . ',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<SavePostBloc, SavePostState>(
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          if (!state.isLoading) {
                            context.read<SavePostBloc>().add(
                                  SavePostUploadEvent(
                                    imagePath: widget.imagePath,
                                    caption: captionController.text,
                                  ),
                                );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: state.isLoading
                            ? const SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Save',
                                style: context.textTheme.titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
