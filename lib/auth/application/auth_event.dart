abstract class AuthEvent {}

class SubmitLoginEvent implements AuthEvent {
  final String email;
  final String password;

  SubmitLoginEvent({required this.email, required this.password});
}

class CheckLoginEvent implements AuthEvent {}
