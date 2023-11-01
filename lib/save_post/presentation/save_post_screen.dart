import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/edit_image/presentation/edit_image_screen.dart';
import 'package:sedigram/save_post/application/save_post_bloc.dart';
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
              actionButton(
                buttonName: 'Save',
                action: () {},
              ),
              actionButton(
                buttonName: 'Edit',
                action: () {
                  Navigator.of(context).pushNamed(
                    EditImageScreen.routeNamed,
                    arguments: widget.imagePath,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget actionButton({
    required String buttonName,
    required VoidCallback action,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: BlocBuilder<SavePostBloc, SavePostState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                if (!state.isLoading) {
                  action();
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
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
                      buttonName,
                      style: context.textTheme.titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
            );
          },
        ),
      ),
    );
  }
}
