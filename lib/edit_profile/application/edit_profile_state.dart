import 'package:sedigram/core/domain/user.dart';

class EditProfileState {
  final bool isLoading;
  final String error;
  final User user;

  EditProfileState({
    required this.isLoading,
    required this.error,
    required this.user,
  });

  EditProfileState.init()
      : isLoading = false,
        error = '',
        user = User.empty();

  EditProfileState copyWith({bool? isLoading, String? error, User? user}) =>
      EditProfileState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        user: user ?? this.user,
      );
}
