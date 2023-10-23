import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/user/application/global_user_event.dart';
import 'package:sedigram/user/application/global_user_state.dart';

class GlobalUserBloc extends Bloc<GlobalUserEvent, GlobalUserState> {
  static final GlobalUserBloc _singleton = GlobalUserBloc._internal(
    firebaseAuth: FirebaseAuth.instance,
    firestoreService: FirestoreService(
      FirebaseFirestore.instance,
    ),
  );
  final FirebaseAuth firebaseAuth;
  final FirestoreService firestoreService;

  factory GlobalUserBloc() {
    return _singleton;
  }

  GlobalUserBloc._internal({
    required this.firebaseAuth,
    required this.firestoreService,
  }) : super(GlobalUserState.init()) {
    on<GlobalUserEvent>((event, emit) async {
      if (event is GlobalUserUpdateEvent) {
        try {
          final userId = firebaseAuth.currentUser!.uid;
          final user = await firestoreService.getUser(userId);
          final userInfo = await firestoreService.getUserInfo(userId);

          emit(
            state.copyWith(
              user: user,
              userInfo: userInfo,
            ),
          );
        } catch (e) {
          debugPrint('$e');
        }
      }
    });
  }
}
