import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/login/application/login_event.dart';
import 'package:sedigram/login/application/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.init()) {
    on<LoginEvent>(
      (event, emit) async {
        if (event is SubmitLoginEvent) {
          try {
            emit(state.copyWith(isLoging: true, loginResult: LoginResult.none));
            final userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            emit(
              state.copyWith(
                isLoging: false,
                loginResult: (userCredential.user != null)
                    ? LoginResult.succeed
                    : LoginResult.failed,
              ),
            );
          } catch (_) {
            emit(
              state.copyWith(isLoging: false, loginResult: LoginResult.failed),
            );
          }
        }
      },
    );
  }
}
