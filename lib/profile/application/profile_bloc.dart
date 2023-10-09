import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/profile/application/profile_event.dart';
import 'package:sedigram/profile/application/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseAuth firebaseAuth;
  final FirestoreService firestoreService;

  ProfileBloc(this.firebaseAuth, this.firestoreService)
      : super(ProfileState.init()) {
    on<ProfileEvent>(
      (event, emit) async {
        if (event is ProfileInitEvent) {
          emit(state.copyWith(isLoading: true));
          try {
            final userId = firebaseAuth.currentUser!.uid;
            final user = await firestoreService.getUser(userId);
            final userInfo = await firestoreService.getUserInfo(userId);

            final posts = await firestoreService.getPosts(userId);

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
