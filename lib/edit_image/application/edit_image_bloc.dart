import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sedigram/edit_image/application/edit_image_event.dart';
import 'package:sedigram/edit_image/application/edit_image_state.dart';

class EditImageBloc extends Bloc<EditImageEvent, EditImageState> {
  EditImageBloc() : super(EditImageState.init()) {
    on((event, emit) async {
      if (event is EditImageInitEvent) {
        final CroppedFile? croppedImage =
            await ImageCropper().cropImage(sourcePath: event.imagePath);

        if (croppedImage != null) {
          final croppedImage = File(event.imagePath);
          emit(state.copyWith(croppedImage: croppedImage.path));
        }
      }
    });
  }
}
