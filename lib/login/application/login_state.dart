// // ignore_for_file: sort_unnamed_constructors_first
//
// class LoginState {
//   final bool isLoging;
//   final LoginResult loginResult;
//
//   LoginState.init()
//       : isLoging = false,
//         loginResult = LoginResult.none;
//
//   LoginState({
//     required this.isLoging,
//     required this.loginResult,
//   });
//
//   LoginState copyWith({bool? isLoging, LoginResult? loginResult}) => LoginState(
//         isLoging: isLoging ?? this.isLoging,
//         loginResult: loginResult ?? this.loginResult,
//       );
// }
//
// enum LoginResult { succeed, failed, none }
