import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/core/presentation/model/post_details_model.dart';
import 'package:sedigram/timeline_screen/application/timeline_event.dart';
import 'package:sedigram/timeline_screen/application/timeline_state.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  final FirebaseAuth firebaseAuth;
  final FirestoreService firestoreService;
  final GlobalUserBloc globalUserBloc;

  TimelineBloc({
    required this.firebaseAuth,
    required this.firestoreService,
    required this.globalUserBloc,
  }) : super(TimelineState.init()) {
    on<TimelineEvent>((event, emit) async {
      if (event is TimelineInitEvent) {
        try {
          emit(state.copyWith(isLoading: true));
          final List<PostDetailModel> allPosts = [];

          final ownerId = globalUserBloc.state.user.userId;
          final posts = await firestoreService.getPosts(ownerId);
          final postDetails = posts
              .map((post) => PostDetailModel(post, globalUserBloc.state.user))
              .toList();
          allPosts.addAll(postDetails);

          final userInfo = await firestoreService.getUserInfo(ownerId);
          final listFollowings = userInfo.followings;
          for (var i = 0; i < listFollowings.length; i++) {
            final userId = listFollowings[i];
            final user = await firestoreService.getUser(userId);
            final userPosts = await firestoreService.getPosts(userId);
            final userPostDetails =
                userPosts.map((post) => PostDetailModel(post, user)).toList();
            allPosts.addAll(userPostDetails);
          }
          //
          // final List<String> allUserId = [];
          // allUserId.add(ownerId);
          //
          // for (var i = 0; i < listFollowings.length; i++) {
          //   final listUserFollowings =
          //       await firestoreService.getUser(listFollowings[i]);
          //   final listUserIdFollowings = listUserFollowings.userName[i];
          //   allUserId.add(listUserIdFollowings);
          // }

          emit(
            state.copyWith(
              isLoading: false,
              listPost: allPosts,
            ),
          );
        } catch (e) {
          debugPrint('$e');
        }
      }
    });
  }
}
