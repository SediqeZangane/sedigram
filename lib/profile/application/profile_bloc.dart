import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/profile/application/profile_event.dart';
import 'package:sedigram/profile/application/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.init()) {
    on<ProfileEvent>(
      (event, emit) async {
        if (event is ProfileInitEvent) {
          emit(state.copyWith(isLoading: true));
          try {
            final userId = FirebaseAuth.instance.currentUser!.uid;
            final user = await FirestoreService().getUser(userId);
            final userInfo = await FirestoreService().getUserInfo(userId);

            emit(
              state.copyWith(
                isLoading: false,
                currentUser: user,
                error: '',
                userInfo: userInfo,
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
