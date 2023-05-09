abstract class AuthEvent {}

class SubmitAuthEvent implements AuthEvent {
  final String email;
  final String password;

  SubmitAuthEvent({required this.email, required this.password});
}
