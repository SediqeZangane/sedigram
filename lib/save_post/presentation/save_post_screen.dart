import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/save_post/application/save_post_bloc.dart';
import 'package:sedigram/save_post/application/save_post_event.dart';
import 'package:sedigram/save_post/application/save_post_state.dart';

class SavePostScreen extends StatelessWidget {
  static const String routeNamed = 'savePostScreen';

  final String imagePath;

  const SavePostScreen({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SavePostBloc, SavePostState>(
      listener: (context, state) {
        if (state.uploaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image Uploaded Successfully'),
            ),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
              const TextField(
                decoration:
                    InputDecoration(hintText: 'Write your caption . . . . '),
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
                            context
                                .read<SavePostBloc>()
                                .add(SavePostUploadEvent(imagePath: imagePath));
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
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
