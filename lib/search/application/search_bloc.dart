import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/search/application/search_event.dart';
import 'package:sedigram/search/application/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FirebaseAuth firebaseAuth;
  final FirestoreService firestoreService;

  SearchBloc({
    required this.firebaseAuth,
    required this.firestoreService,
  }) : super(SearchState.init()) {
    on((event, emit) async {
      if (event is SearchUpdateEvent) {
        final listUser = await firestoreService.getAllUsers(event.text);
        emit(state.copyWith(user: listUser));
      }
    });
  }
}
