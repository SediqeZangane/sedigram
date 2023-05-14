import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: context.colorScheme.onSurface,
          height: (context.screenHeight) / 3,
          child: TextButton(
            child: Text('dddd'),
            onPressed: () async {
              /// Get from gallery

              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              // if (pickedFile != null) {
              //   File imageFile = File(pickedFile.path);
              // }
            },
          ),
        ),
        Container(
          color: context.colorScheme.primary,
          height: (context.screenHeight) / 2,
        ),
      ],
    );
  }
}
