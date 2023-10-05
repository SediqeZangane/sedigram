import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:sedigram/core/data/fire_storage.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/core/domain/posts.dart';
import 'package:sedigram/save_post/application/save_post_event.dart';
import 'package:sedigram/save_post/application/save_post_state.dart';
import 'package:uuid/uuid.dart';

class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {
  SavePostBloc() : super(SavePostState.init()) {
    on<SavePostEvent>(
      (event, emit) async {
        if (event is SavePostUploadEvent) {
          emit(state.copyWith(isLoading: true, uploaded: false));
          final userId = FirebaseAuth.instance.currentUser!.uid;

          final extension = p.extension(event.imagePath);
          final randomId = const Uuid().v4();
          final uniqueRandomName = randomId + extension;

          final imageUrl = await FireStorage().uploadImageFile(
            event.imagePath,
            uniqueRandomName,
            userId,
          );
          if (imageUrl != null) {
            final postId = const Uuid().v4();
            final newPostInfo = Posts(
              postId: postId,
              caption: event.caption,
              imageUrl: imageUrl,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              userId: userId,
            );
            final result = await FireStorage().insertPosts(newPostInfo);
            if (result) {
              emit(state.copyWith(isLoading: false, uploaded: true));
              final userInfo = await FirestoreService().getUserInfo(userId);
              userInfo.posts.add(postId);
              await FirestoreService().updateUserInfo(userInfo);
            } else {
              emit(state.copyWith(isLoading: false, uploaded: false));
            }
          }
        }
      },
    );
  }
}
