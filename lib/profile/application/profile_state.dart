import 'package:sedigram/core/domain/user.dart';

class ProfileState {
  final bool isLoading;
  final User currentUser;
  final String error;

  ProfileState({
    required this.isLoading,
    required this.currentUser,
    required this.error,
  });

  ProfileState.init()
      : isLoading = false,
        currentUser = User.empty(),
        error = '';

  ProfileState copyWith({bool? isLoading, User? currentUser, String? error}) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      error: error ?? this.error,
    );
  }
}
