import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/edit_image/application/edit_image_bloc.dart';
import 'package:sedigram/edit_image/application/edit_image_state.dart';

class EditImageScreen extends StatelessWidget {
  static const String routeNamed = 'editImageScreen';

  const EditImageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditImageBloc, EditImageState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: state.croppedImage != ''
                  ? Image.file(
                      File(state.croppedImage),
                      fit: BoxFit.cover,
                    )
                  : const CircularProgressIndicator(
                      color: Colors.black,
                    ),
            ),
          ),
        );
      },
    );
  }
}
