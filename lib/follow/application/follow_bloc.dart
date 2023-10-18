import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/follow/application/follow_event.dart';
import 'package:sedigram/follow/application/follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final FirestoreService firestoreService;

  FollowBloc({
    required this.firestoreService,
  }) : super(FollowState.init()) {
    on<FollowEvent>((event, emit) async {
      if (event is FollowInitEvent) {
        final followings = event.userInfo.followings;
        final followers = event.userInfo.followers;

        final List<User> listUserFollowings = [];
        for (var i = 0; i < followings.length; i++) {
          final userFollowings = await firestoreService.getUser(followings[i]);
          listUserFollowings.add(userFollowings);
        }
        emit(state.copyWith(listUserFollowings: listUserFollowings));

        final List<User> listUserFollowers = [];
        for (var i = 0; i < followers.length; i++) {
          final userFollowers = await firestoreService.getUser(followers[i]);
          listUserFollowers.add(userFollowers);
        }
        emit(state.copyWith(listUserFollowers: listUserFollowers));
      }
    });
  }
}
