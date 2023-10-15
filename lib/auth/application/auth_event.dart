abstract class AuthEvent {}

class SubmitLoginEvent implements AuthEvent {
  final String email;
  final String password;

  SubmitLoginEvent({required this.email, required this.password});
}

class CheckLoginEvent implements AuthEvent {}

class SubmitGoogleSignInEvent implements AuthEvent {}

class LogOutEvent implements AuthEvent {}

class SubmitSignUpEvent implements AuthEvent {
  final String email;
  final String password;

  SubmitSignUpEvent({required this.email, required this.password});
}
