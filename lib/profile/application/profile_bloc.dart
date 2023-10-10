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
          _userSubscription = globalUserBloc.stream.listen((event) {
            add(ProfileUpdateEvent());
          });
          add(ProfileUpdateEvent());
        } else if (event is ProfileUpdateEvent) {
          emit(state.copyWith(isLoading: true));
          try {
            final userId = firebaseAuth.currentUser!.uid;

            final posts = await firestoreService.getPosts(userId);

            emit(
              state.copyWith(
                isLoading: false,
                error: '',
                posts: posts,
              ),
            );
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
