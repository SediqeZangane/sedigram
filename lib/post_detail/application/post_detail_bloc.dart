import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/core/domain/post.dart';
import 'package:sedigram/core/presentation/model/post_details_model.dart';
import 'package:sedigram/post_detail/application/post_detail_event.dart';
import 'package:sedigram/post_detail/application/post_detail_state.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:sedigram/user/application/global_user_event.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final FirebaseAuth firebaseAuth;
  final FirestoreService firestoreService;
  final GlobalUserBloc globalUserBloc;

  PostDetailBloc({
    required this.firebaseAuth,
    required this.firestoreService,
    required this.globalUserBloc,
  }) : super(PostDetailState.init()) {
    on((event, emit) async {
      if (event is PostDetailInitEvent) {
        final postDetailModels = await getPostDetail(event.posts);
        emit(
          state.copyWith(
            posts: postDetailModels,
          ),
        );
      }
      if (event is PostDetailDeleteEvent) {
        final userId = firebaseAuth.currentUser!.uid;
        await firestoreService.deletePost(userId, event.selectedPost.postId);
        final newPosts = await firestoreService.getPosts(userId);
        final newPostDetailModels = await getPostDetail(newPosts);
        emit(state.copyWith(posts: newPostDetailModels));
        globalUserBloc.add(GlobalUserUpdateEvent());
      }

      if (event is PostDetailLikeEvent) {
        final ownerId = globalUserBloc.state.user.userId;

        final post = await firestoreService.getPost(event.likedPost.postId);
        if (post != null) {
          post.likes.add(ownerId);
          await firestoreService.updatePost(post);
        }

        event.likedPost.likes.add(ownerId);

        final index = state.posts.indexWhere(
          (element) => element.post.postId == event.likedPost.postId,
        );
        if (index != -1) {
          final postDetails = state.posts;
          final postDetail = postDetails[index].copyWith(
            post: post,
            liked: true,
          );
          postDetails[index] = postDetail;
          emit(state.copyWith(posts: postDetails));
        }
      }

      if (event is PostDetailUnLikeEvent) {
        final ownerId = globalUserBloc.state.user.userId;

        final post = await firestoreService.getPost(event.unLikedPost.postId);
        if (post != null) {
          post.likes.remove(ownerId);
          await firestoreService.updatePost(post);
        }

        event.unLikedPost.likes.remove(ownerId);

        final index = state.posts.indexWhere(
          (element) => element.post.postId == event.unLikedPost.postId,
        );
        if (index != -1) {
          final postDetails = state.posts;
          final postDetail = postDetails[index].copyWith(
            post: post,
            liked: false,
          );
          postDetails[index] = postDetail;
          emit(state.copyWith(posts: postDetails));
        }
      }
    });
  }

  Future<List<PostDetailModel>> getPostDetail(List<Post> posts) async {
    final user = await firestoreService.getUser(posts.first.userId);
    final ownerId = globalUserBloc.state.user.userId;

    final postDetailModel = posts
        .map(
          (e) => PostDetailModel(
            e,
            user,
            e.userId == ownerId,
            e.likes.contains(ownerId),
          ),
        )
        .toList();
    return postDetailModel;
  }
}
