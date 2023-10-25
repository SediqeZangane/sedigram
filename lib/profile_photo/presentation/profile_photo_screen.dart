import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/profile_photo/application/profile_photo_bloc.dart';
import 'package:sedigram/profile_photo/application/profile_photo_event.dart';
import 'package:sedigram/profile_photo/application/profile_photo_state.dart';

class ProfilePhotoScreen extends StatelessWidget {
  static const String routeNamed = 'profilePhotoScreen';

  final String imagePath;

  const ProfilePhotoScreen({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              File(imagePath),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: BlocBuilder<ProfilePhotoBloc, ProfilePhotoState>(
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        if (!state.isLoading) {
                          context.read<ProfilePhotoBloc>().add(
                                ProfilePhotoSaveEvent(
                                  imagePath: imagePath,
                                ),
                              );
                          Navigator.of(context).pop();
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
    );
  }
}
