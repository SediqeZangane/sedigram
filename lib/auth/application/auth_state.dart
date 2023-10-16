// ignore_for_file: sort_unnamed_constructors_first

class AuthState {
  final bool isLoading;
  final LoginResult loginResult;
  final bool isLogin;

  AuthState.init()
      : isLoading = false,
        loginResult = LoginResult.none,
        isLogin = false;

  AuthState({
    required this.isLoading,
    required this.loginResult,
    required this.isLogin,
  });

  AuthState copyWith({
    bool? isLoading,
    LoginResult? loginResult,
    bool? isLogin,
  }) =>
      AuthState(
        isLoading: isLoading ?? this.isLoading,
        loginResult: loginResult ?? this.loginResult,
        isLogin: isLogin ?? this.isLogin,
      );
}

enum LoginResult { succeed, logInFailed, signUpFailed, none }
