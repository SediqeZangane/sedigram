import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/save_post/application/save_post_event.dart';
import 'package:sedigram/save_post/application/save_post_state.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {
  SavePostBloc() : super(SavePostState.init()) {
    on<SavePostEvent>(
      (event, emit) async {
        if (event is SavePostUploadEvent) {
          emit(state.copyWith(isLoading: true, uploaded: false));
          final userId = FirebaseAuth.instance.currentUser!.uid;

          final extension = p.extension(event.imagePath);
          final uuId = Uuid();
          final randomId = uuId.v4();
          final uniqueRandomName = randomId + extension;

          final uploadResult = await FirestoreService().uploadImageFile(
            event.imagePath,
            uniqueRandomName,
            userId,
          );
          if (uploadResult) {
            emit(state.copyWith(isLoading: false, uploaded: true));
            final uploadedPath = event.imagePath;

            final storageReference = FirebaseStorage.instance
                .ref('$userId/$uniqueRandomName')
                .child('uniqueRandomName');
            final imageURL = await storageReference.getDownloadURL();
            print('this is the url ::::::::::::: $imageURL');
          } else {
            emit(state.copyWith(isLoading: false, uploaded: false));
          }
        }
      },
    );
  }
}
