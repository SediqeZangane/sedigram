import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/edit_profile/application/edit_profile_event.dart';
import 'package:sedigram/edit_profile/application/edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final FirebaseAuth firebaseAuth;

  EditProfileBloc(this.firebaseAuth) : super(EditProfileState.init()) {
    on<EditProfileEvent>((event, emit) async {
      if (event is EditProfileInitEvent) {
        emit(state.copyWith(isLoading: true));
        try {
          final userId = firebaseAuth.currentUser!.uid;
          final user = await FirestoreService(FirebaseFirestore.instance)
              .getUser(userId);
          emit(state.copyWith(isLoading: false, user: user, error: ''));
        } catch (_) {
          emit(state.copyWith(isLoading: false, error: "Couldn't get user"));
        }
      }
      if (event is EditProfileSaveEvent) {
        try {
          final userId = firebaseAuth.currentUser!.uid;
          final user = event.updateUser.copyWith(userId: userId);

          await FirestoreService(FirebaseFirestore.instance).updateUser(user);
          emit(state.copyWith(saved: true, user: user, error: ''));
        } catch (_) {
          emit(state.copyWith(error: "Couldn't update user"));
        }
      }
    });
  }
}
