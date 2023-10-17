import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/core/domain/post.dart';
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

          final ownerId = globalUserBloc.state.user.userId;
          final posts = await firestoreService.getPosts(ownerId);
          final userName = globalUserBloc.state.user.userName;
          final List<Post> allPosts = [];
          // ignore: cascade_invocations
          allPosts.addAll(posts);
          final userInfo = await firestoreService.getUserInfo(ownerId);
          final listFollowings = userInfo.followings;

          for (var i = 0; i < listFollowings.length; i++) {
            final listPostFollowings =
                await firestoreService.getPosts(listFollowings[i]);
            allPosts.addAll(listPostFollowings);
          }

          emit(
            state.copyWith(
              isLoading: false,
              listPost: allPosts,
              userName: userName,
            ),
          );
        } catch (e) {
          debugPrint('$e');
        }
      }
    });
  }
}
