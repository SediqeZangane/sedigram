import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/auth/application/auth_event.dart';
import 'package:sedigram/auth/application/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.init()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is CheckLoginEvent) {
          final user = FirebaseAuth.instance.currentUser;

          emit(
            state.copyWith(
              isLogin: user != null,
            ),
          );
        }
        if (event is SubmitLoginEvent) {
          try {
            emit(
              state.copyWith(isLoading: true, loginResult: LoginResult.none),
            );
            final userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            emit(
              state.copyWith(
                isLoading: false,
                loginResult: (userCredential.user != null)
                    ? LoginResult.succeed
                    : LoginResult.failed,
              ),
            );
          } catch (_) {
            emit(
              state.copyWith(isLoading: false, loginResult: LoginResult.failed),
            );
          }
        }
      },
    );
  }
}
