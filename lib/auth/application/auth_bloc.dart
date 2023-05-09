import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/auth/application/auth_event.dart';
import 'package:sedigram/auth/application/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.init()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is SubmitAuthEvent) {
          try {
            emit(state.copyWith(isLoading: true, loginResult: AuthResult.none));
            final userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            emit(
              state.copyWith(
                isLoading: false,
                loginResult: (userCredential.user != null)
                    ? AuthResult.succeed
                    : AuthResult.failed,
              ),
            );
          } catch (_) {
            emit(
              state.copyWith(isLoading: false, loginResult: AuthResult.failed),
            );
          }
        }
      },
    );
  }
}
