import 'package:sedigram/core/domain/user.dart';

class EditProfileState {
  final bool isLoading;
  final String error;
  final User user;
  final bool saved;

  EditProfileState({
    required this.isLoading,
    required this.error,
    required this.user,
    required this.saved,
  });

  EditProfileState.init()
      : isLoading = false,
        error = '',
        user = User.empty(),
        saved = false;

  EditProfileState copyWith({
    bool? isLoading,
    String? error,
    User? user,
    bool? saved,
  }) =>
      EditProfileState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        user: user ?? this.user,
        saved: saved ?? this.saved,
      );
}
