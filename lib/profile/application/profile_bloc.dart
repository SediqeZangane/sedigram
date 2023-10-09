import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/profile/application/profile_event.dart';
import 'package:sedigram/profile/application/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  ProfileBloc(this.firebaseAuth, this.firebaseFirestore)
      : super(ProfileState.init()) {
    on<ProfileEvent>(
      (event, emit) async {
        if (event is ProfileInitEvent) {
          emit(state.copyWith(isLoading: true));
          try {
            final userId = firebaseAuth.currentUser!.uid;
            final user =
                await FirestoreService(firebaseFirestore).getUser(userId);
            final userInfo =
                await FirestoreService(firebaseFirestore).getUserInfo(userId);

            final posts =
                await FirestoreService(firebaseFirestore).getPosts(userId);

            emit(
              state.copyWith(
                isLoading: false,
                currentUser: user,
                error: '',
                userInfo: userInfo,
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
}
