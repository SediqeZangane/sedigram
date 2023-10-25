import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/edit_profile/application/edit_profile_event.dart';
import 'package:sedigram/edit_profile/application/edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final FirebaseAuth firebaseAuth;
  final FirestoreService firestoreService;

  EditProfileBloc(this.firebaseAuth, this.firestoreService)
      : super(
          EditProfileState.init(),
        ) {
    on<EditProfileEvent>((event, emit) async {
      if (event is EditProfileInitEvent) {
        emit(state.copyWith(isLoading: true));
        try {
          final userId = firebaseAuth.currentUser!.uid;
          final user = await firestoreService.getUser(userId);
          emit(state.copyWith(isLoading: false, user: user, error: ''));
        } catch (_) {
          emit(state.copyWith(isLoading: false, error: "Couldn't get user"));
        }
      }
      if (event is EditProfileSaveEvent) {
        try {
          //hamechiro user por mikone ,userId va aks ro ma bayad por konim

          final userId = firebaseAuth.currentUser!.uid;

          final user = event.updateUser.copyWith(
            userId: userId,
            profilePicture: state.user.profilePicture,
          );

          await firestoreService.updateUser(user);
          emit(state.copyWith(saved: true, user: user, error: ''));
        } catch (_) {
          emit(state.copyWith(error: "Couldn't update user"));
        }
      }
    });
  }
}
