import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as p;
import 'package:sedigram/core/data/fire_storage.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/core/domain/post.dart';
import 'package:sedigram/save_post/application/save_post_event.dart';
import 'package:sedigram/save_post/application/save_post_state.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:sedigram/user/application/global_user_event.dart';
import 'package:uuid/uuid.dart';

class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {
  final FirebaseAuth firebaseAuth;
  final FireStorage fireStorage;
  final Uuid uuid;
  final FirestoreService firestoreService;
  final GlobalUserBloc globalUserBloc;

  SavePostBloc(
    this.firebaseAuth,
    this.fireStorage,
    this.uuid,
    this.firestoreService,
    this.globalUserBloc,
  ) : super(SavePostState.init()) {
    on<SavePostEvent>(
      (event, emit) async {
        if (event is SavePostInitEvent) {
          emit(
            state.copyWith(
              croppedImage: event.imagePath,
            ),
          );
        }

        if (event is SavePostUploadEvent) {
          emit(state.copyWith(isLoading: true, uploaded: false));
          final userId = firebaseAuth.currentUser!.uid;

          final extension = p.extension(state.croppedImage);
          final randomId = uuid.v4();
          final uniqueRandomName = randomId + extension;

          final imageUrl = await fireStorage.uploadImageFile(
            state.croppedImage,
            uniqueRandomName,
            userId,
          );
          if (imageUrl != null) {
            final postId = uuid.v4();
            final newPostInfo = Post(
              postId: postId,
              caption: event.caption,
              imageUrl: imageUrl,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              userId: userId,
              likes: [],
            );
            final result = await firestoreService.insertPosts(newPostInfo);
            if (result) {
              final userInfo = await firestoreService.getUserInfo(userId);
              userInfo.posts.add(postId);
              await firestoreService.updateUserInfo(userInfo);
              globalUserBloc.add(GlobalUserUpdateEvent());

              emit(state.copyWith(isLoading: false, uploaded: true));
            } else {
              emit(state.copyWith(isLoading: false, uploaded: false));
            }
          }
        }

        if (event is SavePostEditEvent) {
          final CroppedFile? croppedImage =
              await ImageCropper().cropImage(sourcePath: state.croppedImage);

          if (croppedImage != null) {
            emit(
              state.copyWith(
                croppedImage: croppedImage.path,
              ),
            );
          }
        }
      },
    );
  }
}
