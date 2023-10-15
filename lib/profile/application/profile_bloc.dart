import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/profile/application/profile_event.dart';
import 'package:sedigram/profile/application/profile_state.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:sedigram/user/application/global_user_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseAuth firebaseAuth;
  final FirestoreService firestoreService;
  final GlobalUserBloc globalUserBloc;

  StreamSubscription<GlobalUserState>? _userSubscription;

  ProfileBloc(
    this.firebaseAuth,
    this.firestoreService,
    this.globalUserBloc,
  ) : super(ProfileState.init()) {
    on<ProfileEvent>(
      (event, emit) async {
        if (event is ProfileInitEvent) {
          _userSubscription = globalUserBloc.stream.listen((_) {
            add(ProfileUpdateEvent(userId: event.userId));
          });
          add(ProfileUpdateEvent(userId: event.userId));
        } else if (event is ProfileUpdateEvent) {
          emit(state.copyWith(isLoading: true));
          try {
            final ownerId = globalUserBloc.state.user.userId;
            emit(state.copyWith(isMine: ownerId == event.userId));

            final user = await firestoreService.getUser(event.userId);
            emit(state.copyWith(user: user));

            final userInfo = await firestoreService.getUserInfo(event.userId);
            emit(state.copyWith(userInfo: userInfo));

            final posts = await firestoreService.getPosts(event.userId);
            emit(state.copyWith(isLoading: false, error: '', posts: posts));
          } catch (_) {
            emit(state.copyWith(isLoading: false, error: "Couldn't get user"));
          }
        }
      },
    );
  }

  @override
  Future<void> close() async {
    await _userSubscription?.cancel();
    return super.close();
  }
}
