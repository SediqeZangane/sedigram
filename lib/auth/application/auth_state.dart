// ignore_for_file: sort_unnamed_constructors_first

class AuthState {
  final bool isLoading;
  final AuthResult loginResult;

  AuthState.init()
      : isLoading = false,
        loginResult = AuthResult.none;

  AuthState({
    required this.isLoading,
    required this.loginResult,
  });

  AuthState copyWith({bool? isLoading, AuthResult? loginResult}) => AuthState(
        isLoading: isLoading ?? this.isLoading,
        loginResult: loginResult ?? this.loginResult,
      );
}

enum AuthResult { succeed, failed, none }
