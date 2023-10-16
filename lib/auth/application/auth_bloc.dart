import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sedigram/auth/application/auth_event.dart';
import 'package:sedigram/auth/application/auth_state.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:sedigram/user/application/global_user_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final GlobalUserBloc globalUserBloc;

  AuthBloc(
    this.firebaseAuth,
    this.googleSignIn,
    this.globalUserBloc,
  ) : super(AuthState.init()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is CheckLoginEvent) {
          // final firebaseAuth = FirebaseAuth.instance;
          final user = firebaseAuth.currentUser;

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
                await firebaseAuth.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            globalUserBloc.add(GlobalUserUpdateEvent());
            await Future<void>.delayed(const Duration(seconds: 2));

            emit(
              state.copyWith(
                isLoading: false,
                loginResult: (userCredential.user != null)
                    ? LoginResult.succeed
                    : LoginResult.logInFailed,
              ),
            );
          } catch (_) {
            emit(
              state.copyWith(
                isLoading: false,
                loginResult: LoginResult.logInFailed,
              ),
            );
          }
        }

        if (event is SubmitGoogleSignInEvent) {
          try {
            emit(
              state.copyWith(isLoading: true, loginResult: LoginResult.none),
            );
            final googleUser = await googleSignIn.signIn();

            // Obtain the auth details from the request
            final googleAuth = await googleUser?.authentication;

            // Create a new credential
            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken,
            );

            // Once signed in, return the UserCredential
            final userCredential =
                await firebaseAuth.signInWithCredential(credential);
            globalUserBloc.add(GlobalUserUpdateEvent());
            await Future<void>.delayed(const Duration(seconds: 2));

            emit(
              state.copyWith(
                isLoading: false,
                loginResult: (userCredential.user != null)
                    ? LoginResult.succeed
                    : LoginResult.logInFailed,
              ),
            );
          } catch (_) {
            emit(
              state.copyWith(
                isLoading: false,
                loginResult: LoginResult.logInFailed,
              ),
            );
          }
        }

        if (event is LogOutEvent) {
          await FirebaseAuth.instance.signOut();
        }

        if (event is SubmitSignUpEvent) {
          try {
            emit(
              state.copyWith(isLoading: true, loginResult: LoginResult.none),
            );
            final createUserCredential =
                await firebaseAuth.createUserWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );

            await firebaseAuth.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            globalUserBloc.add(GlobalUserUpdateEvent());

            await Future<void>.delayed(const Duration(seconds: 2));
            emit(
              state.copyWith(
                isLoading: false,
                loginResult: (createUserCredential.user != null)
                    ? LoginResult.succeed
                    : LoginResult.signUpFailed,
              ),
            );
          } catch (_) {
            emit(
              state.copyWith(
                isLoading: false,
                loginResult: LoginResult.signUpFailed,
              ),
            );
          }
        }
      },
    );
  }
}
