import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/post_detail/application/post_detail_event.dart';
import 'package:sedigram/post_detail/application/post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final FirebaseAuth firebaseAuth;
  final FirestoreService firestoreService;

  PostDetailBloc({
    required this.firebaseAuth,
    required this.firestoreService,
  }) : super(PostDetailState.init()) {
    on((event, emit) async {
      if (event is PostDetailInitEvent) {
        emit(state.copyWith(posts: event.posts));
      }
      if (event is PostDetailDeleteEvent) {
        final userId = firebaseAuth.currentUser!.uid;
        await firestoreService.deletePost(userId, event.selectedPost.postId);
        final newPosts = await firestoreService.getPosts(userId);
        emit(state.copyWith(posts: newPosts));
      }
    });
  }
}
